(define/contract (min-skips dist speed hoursBefore)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length dist)]
         [eps 1e-9]
         [inf 1e9]
         [dp (make-vector (add1 n) (make-vector (add1 n) inf))])
    (vector-set! (vector-ref dp 0) 0 0.0)
    (for ([i (in-range 1 (add1 n))])
      (for ([j (in-range 0 (add1 i))])
        (let ([d (list-ref dist (sub1 i))])
          (if (> j 0)
              (vector-set! (vector-ref dp i) j
                           (min (vector-ref (vector-ref dp (sub1 i)) j)
                                (let ([t (vector-ref (vector-ref dp (sub1 i)) (sub1 j))])
                                  (+ t (/ d speed)))))
              (vector-set! (vector-ref dp i) j
                           (+ (ceiling (/ (vector-ref (vector-ref dp (sub1 i)) j)
                                         speed))
                                (/ d speed))))))
    (let loop ([j 0])
      (if (> j n)
          -1
          (if (<= (vector-ref (vector-ref dp n) j)
                  (* hoursBefore 3600.0))
              j
              (loop (add1 j)))))))