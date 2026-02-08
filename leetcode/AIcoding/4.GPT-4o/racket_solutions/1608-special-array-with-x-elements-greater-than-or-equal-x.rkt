(define (specialArray nums)
  (define (count-greater-or-equal x)
    (length (filter (lambda (y) (>= y x)) nums)))
  (for/fold ([result -1]) ([x (in-range 0 (+ 1 (length nums)))])
    (let ([count (count-greater-or-equal x)])
      (if (= count x)
          x
          result))))