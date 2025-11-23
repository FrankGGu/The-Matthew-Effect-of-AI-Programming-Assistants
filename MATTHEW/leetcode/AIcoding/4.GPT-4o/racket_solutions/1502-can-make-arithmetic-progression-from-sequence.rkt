(define (can-make-arithmetic-progression arr)
  (define (is-arithmetic? lst)
    (let* ((sorted (sort lst <))
           (d (- (list-ref sorted 1) (list-ref sorted 0))))
      (for/fold ([prev (list-ref sorted 0)]) ([x (in-list (cdr sorted))])
        (if (= (- x prev) d)
            x
            #f))))
  (is-arithmetic? arr))