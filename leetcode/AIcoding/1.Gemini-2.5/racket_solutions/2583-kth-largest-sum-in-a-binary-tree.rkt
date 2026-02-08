#lang racket

(struct TreeNode (val left right))

(define (kth-largest-level-sum root k)
  (let loop ((q (list root))
             (level-sums '()))
    (if (empty? q)
        (list-ref (sort level-sums >) (- k 1))
        (let* ((current-level-nodes q)
               (current-level-sum (apply + (map TreeNode-val current-level-nodes)))
               (next-q (filter (lambda (node) (not (null? node)))
                               (append-map (lambda (node)
                                             (list (TreeNode-left node) (TreeNode-right node)))
                                           current-level-nodes))))
          (loop next-q (append level-sums (list current-level-sum)))))))