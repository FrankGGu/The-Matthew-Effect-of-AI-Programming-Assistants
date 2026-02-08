(define (power-of-two? n)
  (and (> n 0)
       (zero? (bitwise-and n (- n 1)))))