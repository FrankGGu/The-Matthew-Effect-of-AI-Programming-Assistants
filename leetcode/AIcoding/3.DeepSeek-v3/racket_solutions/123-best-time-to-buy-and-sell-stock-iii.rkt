(define/contract (max-profit prices)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length prices)])
    (if (< n 2)
        0
        (let* ([k 2]
               [dp (make-vector (add1 k) (make-vector n 0))])
          (for ([i (in-range 1 (add1 k))])
            (let ([max-diff (- (vector-ref (vector-ref dp (sub1 i)) 0) (list-ref prices 0))])
              (for ([j (in-range 1 n))])
                (vector-set! (vector-ref dp i) j 
                             (max (vector-ref (vector-ref dp i) (sub1 j)) 
                                  (+ (list-ref prices j) max-diff)))
                (set! max-diff (max max-diff 
                                    (- (vector-ref (vector-ref dp (sub1 i)) j) 
                                       (list-ref prices j)))))))
          (vector-ref (vector-ref dp k) (sub1 n))))))