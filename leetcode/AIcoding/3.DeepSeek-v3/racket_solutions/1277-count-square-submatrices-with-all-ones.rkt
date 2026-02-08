(define/contract (count-squares matrix)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length matrix)]
         [n (if (zero? m) 0 (length (car matrix)))]
         [dp (make-vector m (make-vector n 0))]
         [total 0])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (if (or (zero? i) (zero? j))
            (vector-set! (vector-ref dp i) j (list-ref (list-ref matrix i) j))
            (if (zero? (list-ref (list-ref matrix i) j))
                (vector-set! (vector-ref dp i) j 0)
                (vector-set! (vector-ref dp i) j 
                             (add1 (min (vector-ref (vector-ref dp (sub1 i)) j)
                                        (vector-ref (vector-ref dp i) (sub1 j))
                                        (vector-ref (vector-ref dp (sub1 i)) (sub1 j))))))
        (set! total (+ total (vector-ref (vector-ref dp i) j)))))
    total))