(define (findTheWinner n k)
  (define (helper n k)
    (if (= n 1)
        1
        (modulo (+ (helper (- n 1) k) k -1) n 1))
    )
  (+ (helper n k) 1))

(findTheWinner n k)