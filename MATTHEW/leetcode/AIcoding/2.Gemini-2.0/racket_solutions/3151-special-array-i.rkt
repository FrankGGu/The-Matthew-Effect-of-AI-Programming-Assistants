(define (special-array nums)
  (let loop ([x 0])
    (cond
      [(> x (length nums)) -1]
      [(equal? (length (filter (lambda (n) (>= n x)) nums)) x) x]
      [else (loop (+ x 1))])))