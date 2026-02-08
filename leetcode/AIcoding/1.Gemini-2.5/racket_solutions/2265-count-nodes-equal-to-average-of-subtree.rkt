#lang racket

(define (average-of-subtree root)
  (define result-count 0)

  ;; dfs returns a pair (sum-of-subtree . count-of-nodes-in-subtree)
  (define (dfs node)
    (if (null? node)
        (cons 0 0) ; Base case: empty subtree has sum 0 and count 0
        (let* ((left-pair (dfs (TreeNode-left node)))
               (left-sum (car left-pair))
               (left-count (cdr left-pair))
               (right-pair (dfs (TreeNode-right node)))
               (right-sum (car right-pair))
               (right-count (cdr right-pair))
               (current-val (TreeNode-val node))
               (current-sum (+ current-val left-sum right-sum))
               (current-count (+ 1 left-count right-count))
               ;; Average is floored, so use floor-quotient
               (average (floor-quotient current-sum current-count)))

          ;; Check if the current node's value equals the average of its subtree
          (when (= current-val average)
            (set! result-count (+ result-count 1)))

          ;; Return the sum and count for the current subtree
          (cons current-sum current-count))))

  (dfs root) ; Start the DFS traversal
  result-count) ; Return the final count