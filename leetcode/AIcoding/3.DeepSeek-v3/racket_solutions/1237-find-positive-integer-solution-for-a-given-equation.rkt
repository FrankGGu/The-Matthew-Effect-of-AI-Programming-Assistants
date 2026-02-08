(define (custom-function f x y)
  (f x y))

(define (find-solution f z)
  (define result '())
  (for* ([x (in-range 1 1001)]
         [y (in-range 1 1001)]
         #:when (= (custom-function f x y) z))
    (set! result (cons (list x y) result)))
  (reverse result))