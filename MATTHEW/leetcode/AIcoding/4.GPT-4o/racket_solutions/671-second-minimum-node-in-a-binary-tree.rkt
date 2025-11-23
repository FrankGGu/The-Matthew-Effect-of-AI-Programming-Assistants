#lang racket

(struct TreeNode (val left right))

(define (find-second-minimum root)
  (define (dfs node min1 min2)
    (cond
      [(null? node) min2]
      [(= (TreeNode-val node) min1)
       (let ([left-min (dfs (TreeNode-left node) min1 min2)]
             [right-min (dfs (TreeNode-right node) min1 min2)])
         (if (or (null? left-min) (null? right-min))
             (or left-min right-min)
             (min left-min right-min))]
      [else (min (if (< (TreeNode-val node) min2) (TreeNode-val node) min2) min2)])))

  (if (null? root) -1
      (let ([min1 (TreeNode-val root)])
        (let ([min2 (dfs (TreeNode-left root) min1 +inf.0)])
          (let ([min2 (dfs (TreeNode-right root) min1 min2)])
            (if (= min2 +inf.0) -1 min2)))))))

(define (get-second-minimum-tree-node root)
  (find-second-minimum root))