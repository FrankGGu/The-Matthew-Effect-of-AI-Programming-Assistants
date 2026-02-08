(define (sum-root-to-leaf root)
  (define (helper node current-sum)
    (if (null? node)
        0
        (let ([new-sum (+ (* current-sum 2) (node-val node))])
          (if (and (null? (node-left node)) (null? (node-right node)))
              new-sum
              (+ (helper (node-left node) new-sum)
                 (helper (node-right node) new-sum))))))
  (helper root 0))