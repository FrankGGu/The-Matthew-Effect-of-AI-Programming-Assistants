#lang racket

(define (count-nodes-with-highest-score parents)
  (define n (vector-length parents))

  ;; Build adjacency list (children)
  (define children (make-vector n '()))
  (for ([i (in-range n)])
    (let ([p (vector-ref parents i)])
      (unless (= p -1)
        (vector-set! children p (cons i (vector-ref children p))))))

  ;; Mutable variables for max score and count
  (define max-score 0)
  (define count-max-score 0)

  ;; DFS function to calculate subtree sizes and scores
  ;; Returns the size of the subtree rooted at 'node'
  (define (dfs node)
    (define current-node-size 1)
    (define current-node-score 1)

    ;; Iterate through children to get their subtree sizes and update current node's score
    (for ([child (vector-ref children node)])
      (let ([child-subtree-size (dfs child)]) ; Recursively call DFS for child
        (set! current-node-size (+ current-node-size child-subtree-size))
        (set! current-node-score (* current-node-score child-subtree-size))))

    ;; Calculate the size of the "parent part" of the tree
    ;; If node is root, (n - current-node-size) will be 0. We treat it as 1 for multiplication.
    (define parent-part-size (- n current-node-size))
    (when (= parent-part-size 0)
      (set! parent-part-size 1))

    (set! current-node-score (* current-node-score parent-part-size))

    ;; Update max-score and count of nodes with max score
    (cond
      ((> current-node-score max-score)
       (set! max-score current-node-score)
       (set! count-max-score 1))
      ((= current-node-score max-score)
       (set! count-max-score (+ count-max-score 1))))

    ;; Return current node's subtree size
    current-node-size)

  ;; Start DFS from the root (node 0)
  (dfs 0)

  count-max-score)