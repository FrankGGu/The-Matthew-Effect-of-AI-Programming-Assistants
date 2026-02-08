(define/contract (stone-game-v stone-value)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length stone-value)]
         [prefix (make-vector (add1 n) 0)]
         [dp (make-vector (* n n) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref stone-value i))))
    (define (get-sum l r)
      (- (vector-ref prefix (add1 r)) (vector-ref prefix l)))
    (define (helper l r)
      (if (= l r)
          0
          (let ([idx (+ (* l n) r)])
            (if (not (zero? (vector-ref dp idx)))
                (vector-ref dp idx)
                (let loop ([k l] [res 0])
                  (if (>= k r)
                      res
                      (let* ([sum-left (get-sum l k)]
                             [sum-right (get-sum (add1 k) r)]
                             [new-res (if (< sum-left sum-right)
                                          (+ sum-left (helper l k))
                                          (if (> sum-left sum-right)
                                              (+ sum-right (helper (add1 k) r))
                                              (max (+ sum-left (helper l k))
                                                   (+ sum-right (helper (add1 k) r)))))])
                        (loop (add1 k) (max res new-res))))))))))
    (for ([len (in-range 2 (add1 n))])
      (for ([l (in-range 0 (- n len -1))])
        (let ([r (+ l len -1)])
          (helper l r))))
    (helper 0 (sub1 n))))