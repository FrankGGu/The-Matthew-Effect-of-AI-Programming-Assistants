(define-struct TreeNode (val left right))

(define (path-sum-iii root targetSum)
  (define (count-paths-from-node node current-target)
    (cond
      [(null? node) 0]
      [else
       (let* ([node-val (TreeNode-val node)]
              [left-child (TreeNode-left node)]
              [right-child (TreeNode-right node)]
              [remaining-target (- current-target node-val)])
         (+ (if (= node-val current-target) 1 0)
            (count-paths-from-node left-child remaining-target)
            (count-paths-from-node right-child remaining-target)))]))

  (cond
    [(null? root) 0]
    [else
     (+ (count-paths-from-node root targetSum)
        (path-sum-iii (TreeNode-left root) targetSum)
        (path-sum-iii (TreeNode-right root) targetSum))]))