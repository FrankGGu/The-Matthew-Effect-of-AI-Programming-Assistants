(define (consecutiveNumbersSum n)
  (define (count-ways k)
    (if (> (* k (1+ k)) (* 2 n))
        0
        (+ 1 (count-ways (1+ k)))))
  (count-ways 1))

(consecutiveNumbersSum n)