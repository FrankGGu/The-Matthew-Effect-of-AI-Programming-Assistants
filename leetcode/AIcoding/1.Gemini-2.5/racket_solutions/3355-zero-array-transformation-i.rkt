(define (zero-array-transformation-i nums)
  (let-values (((total-ops final-propagated-decrement)
                (for/fold ([total-ops 0]
                           [propagated-decrement 0])
                          ([num (in-list nums)])
                  (let* ([current-val (- num propagated-decrement)]
                         [ops-at-current-index (max 0 current-val)])
                    (values (+ total-ops ops-at-current-index)
                            (+ propagated-decrement ops-at-current-index))))))
    total-ops))