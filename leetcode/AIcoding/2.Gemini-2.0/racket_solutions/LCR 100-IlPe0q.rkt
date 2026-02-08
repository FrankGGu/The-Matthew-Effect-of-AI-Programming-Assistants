(define (minimum-total triangle)
  (let* ([n (length triangle)]
         [dp (make-vector (length (last triangle)) 0)])
    (for ([i (reverse (range 0 n))])
      (for ([j (range 0 (length (list-ref triangle i)))])
        (cond
          [(equal? i (- n 1))
           (vector-set! dp j (list-ref (list-ref triangle i) j))]
          [else
           (vector-set! dp j (+ (list-ref (list-ref triangle i) j)
                                (min (vector-ref dp j) (vector-ref dp (+ j 1)))))])))
    (vector-ref dp 0)))