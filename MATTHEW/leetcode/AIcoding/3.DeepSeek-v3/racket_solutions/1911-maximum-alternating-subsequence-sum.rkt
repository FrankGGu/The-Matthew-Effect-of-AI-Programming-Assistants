(define (max-alternating-sum nums)
  (define n (length nums))
  (define dp (make-vector (+ n 1) (make-vector 2 0)))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! (vector-ref dp i) 0 
                 (max (vector-ref (vector-ref dp (- i 1)) 0) 
                      (vector-ref (vector-ref dp (- i 1)) 1) 
                      (+ (vector-ref nums (- i 1)))))
    (vector-set! (vector-ref dp i) 1 
                 (max (vector-ref (vector-ref dp (- i 1)) 1) 
                      (- (vector-ref (vector-ref dp (- i 1)) 0) 
                         (vector-ref nums (- i 1))))))
  (max (vector-ref (vector-ref dp n) 0) (vector-ref (vector-ref dp n) 1)))