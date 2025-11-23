(define (sumNumbers root)
  (define (helper node current-sum)
    (if (null? node)
        0
        (let ((new-sum (+ current-sum (node-value node))))
          (if (and (null? (left node)) (null? (right node)))
              new-sum
              (+ (helper (left node) new-sum)
                 (helper (right node) new-sum))))))
  (helper root 0))