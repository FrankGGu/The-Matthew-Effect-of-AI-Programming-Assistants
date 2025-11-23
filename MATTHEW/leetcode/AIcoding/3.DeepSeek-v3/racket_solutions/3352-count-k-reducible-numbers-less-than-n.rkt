(define (count-k-reducible-numbers n k)
  (define (prime-factors x)
    (let loop ([x x] [divisor 2] [factors '()])
      (cond [(= x 1) factors]
            [(> (* divisor divisor) x) (cons x factors)]
            [(zero? (modulo x divisor)) (loop (/ x divisor) divisor (cons divisor factors))]
            [else (loop x (add1 divisor) factors)])))

  (define (count-reducible x)
    (let ([factors (prime-factors x)])
      (if (null? factors)
          0
          (let ([unique-factors (remove-duplicates factors)])
            (length unique-factors))))))

  (let loop ([i 2] [count 0])
    (cond [(>= i n) count]
          [(= (count-reducible i) k) (loop (add1 i) (add1 count))]
          [else (loop (add1 i) count)])))
)