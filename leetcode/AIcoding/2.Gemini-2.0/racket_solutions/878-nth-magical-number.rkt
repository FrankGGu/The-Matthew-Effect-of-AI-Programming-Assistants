(define (nth-magical-number n a b)
  (define lcm (lcm a b))
  (define (count x)
    (+ (quotient x a) (quotient x b) (- (quotient x lcm))))

  (define (binary-search low high)
    (if (> low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (>= (count mid) n)
              (binary-search low (- mid 1))
              (binary-search (+ mid 1) high)))))

  (let ((low 0)
        (high (* n (min a b))))
    (modulo (binary-search low high) 1000000007)))