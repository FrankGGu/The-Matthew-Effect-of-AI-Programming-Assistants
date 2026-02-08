(define/contract (min-distance houses k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length houses)]
         [sorted-houses (sort houses <)]
         [cost (make-vector (add1 n) (make-vector (add1 n) 0))])
    (for ([i (in-range 1 (add1 n))])
      (for ([j (in-range i (add1 n))])
        (let ([median (list-ref sorted-houses (quotient (+ i j -1) 2))])
          (for ([m (in-range i (add1 j))])
            (vector-set! (vector-ref cost i) j 
                         (+ (vector-ref (vector-ref cost i) j) 
                            (abs (- (list-ref sorted-houses (sub1 m)) median)))))))
    (let ([dp (make-vector (add1 n) (make-vector (add1 k) +inf.0))])
      (vector-set! (vector-ref dp 0) 0 0)
      (for ([i (in-range 1 (add1 n))])
        (for ([j (in-range 1 (add1 k))])
          (for ([m (in-range 0 i))])
            (vector-set! (vector-ref dp i) j 
                         (min (vector-ref (vector-ref dp i) j) 
                              (+ (vector-ref (vector-ref dp m) (sub1 j)) 
                                 (vector-ref (vector-ref cost (add1 m)) i)))))))
      (vector-ref (vector-ref dp n) k))))