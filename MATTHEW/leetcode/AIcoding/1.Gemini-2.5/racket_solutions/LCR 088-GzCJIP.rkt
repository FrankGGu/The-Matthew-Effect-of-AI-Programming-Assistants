(define (min-cost-climbing-stairs cost)
  (let* ([n (vector-length cost)]
         [dp (make-vector n)])
    (vector-set! dp 0 (vector-ref cost 0))
    (vector-set! dp 1 (vector-ref cost 1))
    (for ([i (in-range 2 n)])
      (vector-set! dp i
                   (+ (vector-ref cost i)
                      (min (vector-ref dp (- i 1))
                           (vector-ref dp (- i 2))))))
    (min (vector-ref dp (- n 1))
         (vector-ref dp (- n 2)))))