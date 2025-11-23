(define (numOfFireworks light)
  (define (helper n)
    (if (zero? n)
        0
        (+ (if (zero? (modulo n 2)) 1 0) (helper (quotient n 2)))))
  (helper light))

(define (solve)
  (define input (read))
  (display (numOfFireworks input)))

(solve)