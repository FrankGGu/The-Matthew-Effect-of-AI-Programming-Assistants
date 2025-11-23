(define/contract (maximal-square matrix)
  (-> (listof (listof char?)) exact-integer?)
  (if (null? matrix)
      0
      (let* ([rows (length matrix)]
             [cols (length (car matrix))]
             [dp (make-vector rows (make-vector cols 0))]
             [max-side 0])
        (for ([i (in-range rows)])
          (for ([j (in-range cols)])
            (when (or (zero? i) (zero? j))
              (vector-set! (vector-ref dp i) j 
                (if (char=? (list-ref (list-ref matrix i) j) #\1) 1 0)))
              (set! max-side (max max-side (vector-ref (vector-ref dp i) j)))
              (continue))
            (if (char=? (list-ref (list-ref matrix i) j) #\1)
                (let ([min-prev (min (vector-ref (vector-ref dp (sub1 i)) j)
                                     (vector-ref (vector-ref dp i) (sub1 j))
                                     (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))])
                  (vector-set! (vector-ref dp i) j (add1 min-prev))
                  (set! max-side (max max-side (vector-ref (vector-ref dp i) j))))
                (vector-set! (vector-ref dp i) j 0)))
        (* max-side max-side))))