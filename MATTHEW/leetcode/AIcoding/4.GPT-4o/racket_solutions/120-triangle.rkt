(define (minimum-total triangle)
  (define (dp i j)
    (if (= i (length triangle)) 0
        (+ (list-ref (list-ref triangle i) j) 
           (min (dp (+ i 1) j) (dp (+ i 1) (+ j 1))))))
  (dp 0 0))