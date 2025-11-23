#lang racket

(require data/queue)
(require racket/hash)

(struct tree-node (val left right))

(define (build-graph root)
  (define graph (make-hash)) ; Maps node value to a list of neighbor values

  (define (add-edge u v)
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! graph v (cons u (hash-ref graph v '()))))

  (define (dfs node)
    (when node
      (define current-val (tree-node-val node))
      ;; Ensure the current node's value is in the graph, even if it has no neighbors (e.g., a leaf node)
      (unless (hash-has-key? graph current-val)
        (hash-set! graph current-val '()))

      (when (tree-node-left node)
        (add-edge current-val (tree-node-val (tree-node-left node))))
      (when (tree-node-right node)
        (add-edge current-val (tree-node-val (tree-node-right node))))

      (dfs (tree-node-left node))
      (dfs (tree-node-right node))))

  (dfs root)
  graph)

(define (amount-of-time-for-binary-tree-to-be-infected root start)
  (when (not root)
    0)

  (define graph (build-graph root))
  (define q (make-queue))
  (define visited (make-hash)) ; Maps node value to #t if visited
  (define max-time 0)

  ;; Initialize BFS queue with the start node and time 0
  (queue-enqueue! q (cons start 0)) ; Queue elements are (node-val . time)
  (hash-set! visited start #t)

  (let loop ()
    (unless (queue-empty? q)
      (define current-pair (queue-dequeue! q))
      (define current-val (car current-pair))
      (define current-time (cdr current-pair))

      ;; Update the maximum time taken
      (set! max-time (max max-time current-time))

      ;; Get neighbors of the current node
      ;; Use '() as default if current-val is not found in graph (should not happen if build-graph is correct)
      (define neighbors (hash-ref graph current-val '()))
      (for-each
       (lambda (neighbor-val)
         (unless (hash-has-key? visited neighbor-val)
           (hash-set! visited neighbor-val #t)
           (queue-enqueue! q (cons neighbor-val (+ current-time 1)))))
       neighbors)
      (loop)))
  max-time)