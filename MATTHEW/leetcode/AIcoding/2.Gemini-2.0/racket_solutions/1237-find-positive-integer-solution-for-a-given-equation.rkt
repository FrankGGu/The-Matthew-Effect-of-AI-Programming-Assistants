(define (findSolution customFunction z)
  (define result '())
  (for* ([x (in-range 1 1001)]
         [y (in-range 1 1001)]
         #:when (= z (customFunction x y)))
    (set! result (cons (list x y) result)))
  (reverse result))