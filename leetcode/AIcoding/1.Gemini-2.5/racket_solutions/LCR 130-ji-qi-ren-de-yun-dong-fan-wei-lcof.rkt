(define (change amount coins)
  (define dp (make-vector (+ amount 1) 0))
  (vector-set! dp 0 1)

  (for-each
   (lambda (coin)
     (for ((i (in-range coin (+ amount 1))))
       (vector-set! dp i
                    (+ (vector-ref dp i)
                       (vector-ref dp (- i coin))))))
   coins)

  (vector-ref dp amount))