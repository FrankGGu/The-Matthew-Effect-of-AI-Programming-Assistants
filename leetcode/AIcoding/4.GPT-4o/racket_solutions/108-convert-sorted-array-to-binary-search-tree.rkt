#lang racket

(struct TreeNode (val left right))

(define (sortedArrayToBST nums)
  (define (helper start end)
    (if (> start end)
        #f
        (let* ((mid (quotient (+ start end) 2))
               (node (TreeNode (list-ref nums mid))))
          (set-left! node (helper start (- mid 1)))
          (set-right! node (helper (+ mid 1) end))
          node)))
  (helper 0 (- (length nums) 1)))