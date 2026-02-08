(define (self-dividing-numbers left right)
  (define (is-self-dividing? n)
    (let loop ((temp n))
      (if (zero? temp)
          #t
          (let ((digit (remainder temp 10)))
            (if (or (zero? digit) (not (zero? (remainder n digit))))
                #f
                (loop (quotient temp 10)))))))
  (filter is-self-dividing? (for/list ((i (in-range left (+ right 1)))) i)))