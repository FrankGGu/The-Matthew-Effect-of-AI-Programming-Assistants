#lang racket

(struct TreeNode (val left right) #:transparent)

(struct result (is-bst? min-val max-val sum max-overall-bst-sum) #:transparent)

(define (maximum-sum-bst root)
  (define (dfs node)
    (if (null? node)
        (result #t +inf.0 -inf.0 0 0)
        (let* ([left-res (dfs (TreeNode-left node))]
               [right-res (dfs (TreeNode-right node))]
               [current-val (TreeNode-val node)]

               [left-is-bst? (result-is-bst? left-res)]
               [left-min (result-min-val left-res)]
               [left-max (result-max-val left-res)]
               [left-sum (result-sum left-res)]
               [left-max-overall-bst-sum (result-max-overall-bst-sum left-res)]

               [right-is-bst? (result-is-bst? right-res)]
               [right-min (result-min-val right-res)]
               [right-max (result-max-val right-res)]
               [right-sum (result-sum right-res)]
               [right-max-overall-bst-sum (result-max-overall-bst-sum right-res)])

          (if (and left-is-bst?
                   right-is-bst?
                   (< left-max current-val)
                   (> right-min current-val))
              (let* ([current-subtree-sum (+ current-val left-sum right-sum)]
                     [current-min (min current-val left-min)]
                     [current-max (max current-val right-max)]
                     [max-bst-sum-here (max current-subtree-sum
                                            left-max-overall-bst-sum
                                            right-max-overall-bst-sum)])
                (result #t current-min current-max current-subtree-sum max-bst-sum-here))
              (let ([max-bst-sum-here (max left-max-overall-bst-sum
                                           right-max-overall-bst-sum)])
                (result #f -inf.0 +inf.0 0 max-bst-sum-here))))))

  (max 0 (result-max-overall-bst-sum (dfs root))))