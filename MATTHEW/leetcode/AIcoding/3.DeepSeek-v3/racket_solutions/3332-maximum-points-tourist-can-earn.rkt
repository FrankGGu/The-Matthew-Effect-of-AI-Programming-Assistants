(define/contract (max-points points k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([n (length points)]
         [m (length (car points))]
         [dp (make-vector (add1 k) 0)])
    (for ([i (in-range 1 (add1 k))])
      (for ([j (in-range 1 (add1 n))])
        (vector-set! dp i
          (max (vector-ref dp i)
               (+ (vector-ref dp (- i (list-ref (list-ref points (sub1 j)) 0)))
                  (list-ref (list-ref points (sub1 j)) 1))))))
    (vector-ref dp k)))