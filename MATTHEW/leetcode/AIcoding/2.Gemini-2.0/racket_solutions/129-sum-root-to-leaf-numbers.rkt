(define (sum-numbers root)
  (define (helper node current-sum)
    (cond
      [(null? node) 0]
      [else
       (let ((new-sum (+ (* current-sum 10) (car node))))
         (if (and (null? (cadr node)) (null? (caddr node)))
             new-sum
             (+ (helper (cadr node) new-sum)
                (helper (caddr node) new-sum))))]))
  (helper root 0))