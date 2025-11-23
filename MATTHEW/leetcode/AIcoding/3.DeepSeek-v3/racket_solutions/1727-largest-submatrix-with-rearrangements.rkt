(define/contract (largest-submatrix matrix)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length matrix)]
         [n (if (zero? m) 0 (length (car matrix)))]
         [dp (make-vector m (make-vector n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (if (zero? i)
            (vector-set! (vector-ref dp i) j (list-ref (list-ref matrix i) j))
            (vector-set! (vector-ref dp i) j 
                         (if (zero? (list-ref (list-ref matrix i) j)) 
                             0 
                             (+ (vector-ref (vector-ref dp (- i 1)) j) 1))))))
    (let ([ans 0])
      (for ([i (in-range m)])
        (let ([row (vector->list (vector-ref dp i))])
          (set! row (sort row >))
          (for ([j (in-range n)])
            (set! ans (max ans (* (+ j 1) (list-ref row j))))))
      ans)))