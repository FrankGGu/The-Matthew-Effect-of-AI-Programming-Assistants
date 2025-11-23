(define (special-array nums)
  (define (count-greater-equal x)
    (length (filter (lambda (n) (>= n x)) nums)))

  (let loop ([x 1])
    (cond
      [(> x (length nums)) -1]
      [(= x (count-greater-equal x)) x]
      [else (loop (+ x 1))])))