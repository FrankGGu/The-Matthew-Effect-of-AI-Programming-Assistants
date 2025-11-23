(define/contract (box-delivering boxes portsCount maxBoxes maxWeight)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer? exact-integer?)
  (let* ([n (length boxes)]
         [dp (make-vector (add1 n) +inf.0)]
         [prefix (make-vector (add1 n) 0)]
         [diff (make-vector (add1 n) 0)])
    (vector-set! dp 0 0)
    (vector-set! prefix 0 0)
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (second (list-ref boxes (sub1 i)))))
    (for ([i (in-range 1 (add1 n))])
      (vector-set! diff i (if (or (= i 1) (not (= (first (list-ref boxes (sub1 i))) (first (list-ref boxes (- i 2))))))
                              (add1 (vector-ref diff (sub1 i)))
                              (vector-ref diff (sub1 i)))))
    (let loop ([i 1] [j 0] [w 0] [b 0] [cost 0])
      (when (<= i n)
        (let* ([box (list-ref boxes (sub1 i))]
               [port (first box)]
               [weight (second box)]
               [new-w (+ w weight)]
               [new-b (add1 b)])
          (if (and (<= new-w maxWeight) (<= new-b maxBoxes))
              (begin
                (let ([new-cost (if (or (= i 1) (not (= port (first (list-ref boxes (- i 2))))))
                                    (add1 cost)
                                    cost)])
                  (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) (add1 (vector-ref diff i)) (vector-ref diff j)))))
                  (loop (add1 i) j new-w new-b new-cost))
              (begin
                (loop i (add1 j) (- w (second (list-ref boxes (sub1 j)))) (sub1 b) (if (or (= j 0) (not (= (first (list-ref boxes (sub1 j))) (first (list-ref boxes j)))))
                                                                                        (sub1 cost)
                                                                                        cost))))))))
    (vector-ref dp n)))