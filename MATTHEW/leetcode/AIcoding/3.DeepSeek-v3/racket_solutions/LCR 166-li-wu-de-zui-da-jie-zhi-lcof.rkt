(define (jewellery-value grid)
  (let* ([m (length grid)]
         [n (if (zero? m) 0 (length (car grid)))]
         [dp (make-vector m (make-vector n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let ([up (if (zero? i) 0 (vector-ref (vector-ref dp (- i 1)) j))]
              [left (if (zero? j) 0 (vector-ref (vector-ref dp i) (- j 1)))]
              [current (list-ref (list-ref grid i) j)])
          (vector-set! (vector-ref dp i) j (+ current (max up left))))))
    (if (zero? m) 0 (vector-ref (vector-ref dp (- m 1)) (- n 1)))))