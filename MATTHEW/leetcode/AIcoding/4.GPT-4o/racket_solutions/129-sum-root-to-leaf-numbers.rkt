(define (sumNumbers root)
  (define (helper node currentSum)
    (if (null? node)
        0
        (let* ((newSum (+ currentSum (node-val node)))
               (leftSum (helper (node-left node) newSum))
               (rightSum (helper (node-right node) newSum)))
          (if (and (null? (node-left node)) (null? (node-right node)))
              newSum
              (+ leftSum rightSum)))))
  (helper root 0))