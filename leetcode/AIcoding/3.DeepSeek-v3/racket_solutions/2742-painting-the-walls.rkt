(define/contract (paint-walls cost time)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length cost)]
         [dp (make-vector (add1 n) +inf.0)])
    (vector-set! dp 0 0)
    (for ([i (in-range n)])
      (let ([c (list-ref cost i)]
            [t (list-ref time i)])
        (for ([j (in-range n (sub1 (add1 t)) -1)])
          (vector-set! dp j (min (vector-ref dp j)
                                 (+ c (vector-ref dp (max 0 (- j (add1 t))))))))))
    (vector-ref dp n)))