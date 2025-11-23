(define/contract (cherry-pickup grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([rows (length grid)]
         [cols (if (zero? rows) 0 (length (car grid))))]
         [dp (make-vector rows (make-vector cols (make-vector cols -1)))]
         [dfs (lambda (r c1 c2)
                (if (or (>= r rows) (< c1 0) (>= c1 cols) (< c2 0) (>= c2 cols))
                    -inf.0
                    (let ([val (vector-ref (vector-ref (vector-ref dp r) c1) c2)])
                      (if (not (= val -1))
                          val
                          (let* ([cherries (if (= c1 c2)
                                               (list-ref (list-ref grid r) c1)
                                               (+ (list-ref (list-ref grid r) c1)
                                                  (list-ref (list-ref grid r) c2)))]
                                 [max-next 0.0])
                            (for ([dc1 (in-list '(-1 0 1))])
                              (for ([dc2 (in-list '(-1 0 1))])
                                (set! max-next (max max-next (dfs (+ r 1) (+ c1 dc1) (+ c2 dc2))))))
                            (vector-set! (vector-ref (vector-ref dp r) c1) c2 (+ cherries max-next))
                            (vector-ref (vector-ref (vector-ref dp r) c1) c2)))))])
    (max 0 (dfs 0 0 (- cols 1)))))