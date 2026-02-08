(define (winner square)
  (define (dp n)
    (if (zero? n)
        #f
        (for/or ([i (in-range 1 (add1 (integer-sqrt n)))])
          (let ([s (* i i)])
            (and (<= s n) (not (dp (- n s)))))))
    )
  (dp square))

(define (stoneGameIV n)
  (winner n))