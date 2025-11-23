#lang racket

(struct node (name children full-path deleted) #:mutable) ; children is a hash table string -> node

(define (path<? p1 p2)
  (string<? (string-join p1 "/") (string-join p2 "/")))

(define (solve paths)
  ;; 1. Build the tree
  ;; Dummy root node. Its name is "", full-path is '().
  (define root (node "" (make-hash) '() #f))

  (for-each (lambda (path)
              (define current-node root)
              (define current-path-accumulator '()) ; Builds path from root to current folder
              (for-each (lambda (folder-name)
                          (set! current-path-accumulator (append current-path-accumulator (list folder-name)))
                          (unless (hash-has-key? (node-children current-node) folder-name)
                            (hash-set! (node-children current-node)
                                       folder-name
                                       (node folder-name (make-hash) current-path-accumulator #f)))
                          (set! current-node (hash-ref (node-children current-node) folder-name)))
                        path))
            paths)

  ;; 2. Serialize and Detect Duplicates (DFS Post-Order)
  ;;    node-serializations: hash map (serialization-string -> list of nodes)
  (define node-serializations (make-hash))

  (define (dfs current-node)
    (define children-keys (sort (hash-keys (node-children current-node)) string<?))
    (define child-serializations
      (map (lambda (key)
             (dfs (hash-ref (node-children current-node) key)))
           children-keys))

    (define current-serialization
      (string-append
       "("
       (node-name current-node)
       (if (empty? child-serializations)
           ""
           (string-append " " (string-join child-serializations " ")))
       ")"))

    ;; Add current-node to the list for its serialization
    ;; Only consider non-root nodes for duplication detection
    (unless (string=? (node-name current-node) "")
      (hash-set! node-serializations
                 current-serialization
                 (cons current-node (hash-ref node-serializations current-serialization '()))))
    current-serialization)

  ;; Start DFS from the dummy root
  (dfs root)

  ;; 3. Mark for Deletion
  (hash-for-each (lambda (serialization nodes-list)
                   (when (> (length nodes-list) 1)
                     ;; Sort nodes by their full path (lexicographically)
                     (define sorted-nodes (sort nodes-list (lambda (n1 n2) (path<? (node-full-path n1) (node-full-path n2)))))
                     ;; Keep the first node, mark the rest for deletion
                     (for-each (lambda (n) (set-node-deleted! n #t)) (rest sorted-nodes))))
                 node-serializations)

  ;; 4. Reconstruct Paths (DFS Pre-Order)
  (define result-paths '())

  (define (reconstruct-dfs current-node)
    (unless (node-deleted current-node)
      ;; Only add to result if it's not the dummy root
      (when (not (string=? (node-name current-node) ""))
        (set! result-paths (cons (node-full-path current-node) result-paths)))

      (define children-keys (sort (hash-keys (node-children current-node)) string<?))
      (for-each (lambda (key)
                  (define child-node (hash-ref (node-children current-node) key))
                  (reconstruct-dfs child-node))
                children-keys)))

  ;; Start reconstruction from the dummy root
  (reconstruct-dfs root)

  ;; The result-paths are collected in reverse order of traversal (due to cons), and also
  ;; the order of children keys is sorted.
  ;; The problem asks for the result to be sorted lexicographically.
  (sort result-paths path<?))