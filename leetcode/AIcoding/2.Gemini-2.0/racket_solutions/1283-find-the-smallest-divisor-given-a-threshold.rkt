(define (smallestDivisor nums threshold)
  (define (sum-division divisor)
    (apply + (map (lambda (x) (ceiling (/ x divisor))) nums)))

  (define (binary-search low high)
    (if (<= low high)
        (let ((mid (floor (+ low high) 2)))
          (let ((sum (sum-division mid)))
            (if (<= sum threshold)
                (binary-search low (- mid 1))
                (binary-search (+ mid 1) high))))
        low))

  (binary-search 1 (apply max nums)))