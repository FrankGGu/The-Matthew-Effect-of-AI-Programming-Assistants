(define (count-special-subsequences nums)
  (define mod 1000000007)
  (define zero (make-vector 3 0))
  (vector-set! zero 0 1)
  (for ([num nums])
    (cond
      [(equal? num 0)
       (vector-set! zero 0 (modulo (+ (vector-ref zero 0) (vector-ref zero 0)) mod))]
      [(equal? num 1)
       (vector-set! zero 1 (modulo (+ (vector-ref zero 0) (vector-ref zero 1)) mod))]
      [(equal? num 2)
       (vector-set! zero 2 (modulo (+ (vector-ref zero 1) (vector-ref zero 2)) mod))]))
  (vector-ref zero 2))