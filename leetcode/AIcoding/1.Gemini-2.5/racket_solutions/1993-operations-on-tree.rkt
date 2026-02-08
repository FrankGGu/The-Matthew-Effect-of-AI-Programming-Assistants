#lang racket

(define (build-children parent nums)
  (define children (make-vector nums '()))
  (for ([i (in-range 1 nums)]) ; Iterate from node 1 up to nums-1 (node 0 is the root)
    (define p (vector-ref parent i))
    (vector-set! children p (cons i (vector-ref children p))))
  children)

(struct tree-lock (parent children locked-by) #:mutable)

(define (TreeLock parent nums)
  (define children-adj (build-children parent nums))
  ;; `locked-by` vector: #f means unlocked, an integer (user ID) means locked by that user.
  (define locked-status (make-vector nums #f))
  (tree-lock parent children-adj locked-status))

(define (is-ancestor-locked? self node)
  (let loop ([curr (vector-ref (tree-lock-parent self) node)]) ; Start checking from the immediate parent
    (if (= curr -1)
        #f ; Reached the root's parent (-1), no locked ancestor found
        (if (vector-ref (tree-lock-locked-by self) curr)
            #t ; Current node (an ancestor) is locked
            (loop (vector-ref (tree-lock-parent self) curr))))))

(define (get-locked-descendants self node)
  (define locked-descendants-list '())
  (define (dfs curr)
    (define locked-status (vector-ref (tree-lock-locked-by self) curr))
    (when locked-status
      (set! locked-descendants-list (cons curr locked-descendants-list))) ; Add node ID to the list if locked
    (for ([child (in-list (vector-ref (tree-lock-children self) curr))])
      (dfs child)))

  ;; Start DFS from the direct children of 'node' (node itself is not a descendant)
  (for ([child (in-list (vector-ref (tree-lock-children self) node))])
    (dfs child))
  locked-descendants-list)

(define (tree-lock-lock! self num user)
  (define locked-by (tree-lock-locked-by self))
  (and (not (vector-ref locked-by num)) ; Condition 1: Node is currently unlocked
       (not (is-ancestor-locked? self num)) ; Condition 2: None of its ancestors are locked
       (begin
         (vector-set! locked-by num user) ; Lock the node by the user
         #t)))

(define (tree-lock-unlock! self num user)
  (define locked-by (tree-lock-locked-by self))
  (and (equal? (vector-ref locked-by num) user) ; Condition 1: Node is locked by the specified user
       (begin
         (vector-set! locked-by num #f) ; Unlock the node
         #t)))

(define (tree-lock-upgrade! self num user)
  (define locked-by (tree-lock-locked-by self))
  (and (not (vector-ref locked-by num)) ; Condition 1: Node is currently unlocked
       (not (is-ancestor-locked? self num)) ; Condition 2: None of its ancestors are locked
       (let ([locked-descendants (get-locked-descendants self num)])
         (and (not (null? locked-descendants)) ; Condition 3: At least one descendant is locked
              (begin
                ;; Condition 4: Unlock all locked descendants
                (for ([descendant-node (in-list locked-descendants)])
                  (vector-set! locked-by descendant-node #f))
                ;; Lock the current node by the user
                (vector-set! locked-by num user)
                #t)))))