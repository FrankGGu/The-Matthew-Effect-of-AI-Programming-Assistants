#lang racket

(define (distance-k root target k)
  ;; 1. Build an undirected graph (adjacency list) from the tree.
  ;;    The graph maps node values to a list of neighbor node values.
  (define graph (make-hash))

  (define (build-graph-dfs node parent-val)
    (when node
      (let ((node-val (TreeNode-val node)))
        ;; Ensure the current node has an entry in the graph
        (unless (hash-has-key? graph node-val)
          (hash-set! graph node-val '()))

        ;; If there's a parent, add edges between current node and parent
        (when parent-val
          (hash-update! graph node-val (lambda (neighbors) (cons parent-val neighbors)))
          (hash-update! graph parent-val (lambda (neighbors) (cons node-val neighbors))))

        ;; Recurse for children
        (build-graph-dfs (TreeNode-left node) node-val)
        (build-graph-dfs (TreeNode-right node) node-val))))

  ;; Start building the graph from the root. The root has no parent.
  (build-graph-dfs root #f)

  ;; 2. Perform a Breadth-First Search (BFS) starting from the target node.
  ;;    The queue will store lists of (current-node-value distance-from-target).
  (require racket/queue) ; For make-queue, queue-add!, queue-remove!, queue-empty?
  (define q (make-queue))
  (queue-add! q (list (TreeNode-val target) 0))

  ;; Keep track of visited nodes to avoid cycles and redundant processing.
  (define visited (make-hash))
  (hash-set! visited (TreeNode-val target) #t)

  (define result '()) ; Accumulator for nodes at distance K

  (let loop ()
    (when (not (queue-empty? q))
      (let* ((current-item (queue-remove! q))
             (current-val (car current-item))
             (current-dist (cadr current-item)))

        ;; If current node is at distance K, add its value to the result.
        (when (= current-dist k)
          (set! result (cons current-val result)))

        ;; If current distance exceeds K, no need to explore further from this path.
        ;; (BFS ensures we find shortest paths, so any further nodes from this path
        ;; will have distance > K).
        (when (< current-dist k)
          (let ((neighbors (hash-ref graph current-val '())))
            (for-each (lambda (neighbor-val)
                        (unless (hash-has-key? visited neighbor-val)
                          (hash-set! visited neighbor-val #t)
                          (queue-add! q (list neighbor-val (+ current-dist 1)))))
                      neighbors))))
      (loop)))

  ;; Reverse the result list because elements were added using cons (prepend).
  (reverse result))