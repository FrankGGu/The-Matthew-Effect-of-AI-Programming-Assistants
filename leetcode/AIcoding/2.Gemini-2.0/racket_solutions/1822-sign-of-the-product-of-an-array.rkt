(define (array-sign nums)
  (let loop ([nums nums] [sign 1])
    (cond
      [(empty? nums) sign]
      [(zero? (car nums)) 0]
      [(negative? (car nums)) (loop (cdr nums) (- sign))]
      [else (loop (cdr nums) sign)])))