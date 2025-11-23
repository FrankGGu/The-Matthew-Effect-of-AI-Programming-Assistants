(define (zigzag-array nums)
  (define (count-removals nums is-left?)
    (define (helper nums prev count)
      (cond [(null? nums) count]
            [else
             (let ([current (car nums)])
               (if (and (not is-left?) (<= current prev))
                   (helper (cdr nums) prev (+ count 1))
                   (if (and is-left? (>= current prev))
                       (helper (cdr nums) prev (+ count 1))
                       (helper (cdr nums) current count))))]))
    (helper nums -inf.0 0))
  (min (count-removals nums #f) (count-removals nums #t)))