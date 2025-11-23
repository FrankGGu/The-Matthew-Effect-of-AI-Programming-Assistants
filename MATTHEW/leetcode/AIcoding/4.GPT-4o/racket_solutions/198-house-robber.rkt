(define (rob nums)
  (define (helper nums)
    (define n (length nums))
    (cond
      [(= n 0) 0]
      [(= n 1) (car nums)]
      [else
       (define dp (make-vector n 0))
       (vector-set! dp 0 (car nums))
       (vector-set! dp 1 (max (car nums) (vector-ref dp 0)))
       (for ([i (in-range 2 n)])
         (vector-set! dp i (max (vector-ref dp (- i 1)) (+ (vector-ref dp (- i 2)) (vector-ref nums i)))))
       (vector-ref dp (- n 1))]))
  (helper nums))