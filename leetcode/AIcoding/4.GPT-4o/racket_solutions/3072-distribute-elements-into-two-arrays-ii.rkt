(define (distribute-elements nums)
  (let* ([n (length nums)]
         [result (vector (make-vector (/ n 2) 0) (make-vector (/ n 2) 0))])
         [sorted-nums (sort nums <)])
    (for ([i (in-range n)])
      (vector-set! (if (even? i) (vector-ref result 0) (vector-ref result 1)) 
                    (quotient i 2) 
                    (vector-ref sorted-nums i)))
    result))