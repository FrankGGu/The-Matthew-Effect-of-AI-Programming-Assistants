(define (min-operations nums)
  (if (empty? nums)
      0
      (let* ([first-val (car nums)]
             [rest-nums (cdr nums)])
        (define-values (final-operations final-prev-val)
          (for/fold ([operations 0]
                     [prev-val first-val])
                    ([current-val (in-list rest-nums)])
            (if (<= current-val prev-val)
                (let ([needed-ops (+ (- prev-val current-val) 1)])
                  (values (+ operations needed-ops)
                          (+ prev-val 1)))
                (values operations
                        current-val))))
        final-operations)))