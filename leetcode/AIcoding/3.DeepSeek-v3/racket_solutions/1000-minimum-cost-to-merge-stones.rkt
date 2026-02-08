(define/contract (merge-stones stones k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length stones)]
         [dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))]
         [sum (make-vector (+ n 1) 0)])
    (if (not (= (modulo (- n 1) (- k 1)) 0)) -1
        (begin
          (for ([i (in-range 1 (+ n 1))])
            (vector-set! sum i (+ (vector-ref sum (- i 1)) (list-ref stones (- i 1)))))
          (for ([len (in-range k (+ n 1))])
            (for ([i (in-range 1 (- (+ n 1) len -1))])
              (let ([j (+ i len -1)])
                (vector-set! (vector-ref dp i) j +inf.0)
                (for ([t (in-range i j (- k 1))])
                  (vector-set! (vector-ref dp i) j 
                               (min (vector-ref (vector-ref dp i) j)
                                    (+ (vector-ref (vector-ref dp i) t)
                                       (vector-ref (vector-ref dp (+ t 1)) j))))
                (when (= (modulo (- len 1) (- k 1)) 0)
                  (vector-set! (vector-ref dp i) j
                               (+ (vector-ref (vector-ref dp i) j)
                                    (vector-ref sum j)
                                    (- (vector-ref sum (- i 1)))))))))
          (vector-ref (vector-ref dp 1) n)))))