(define (kth-ancestor n parents k)
  (let* ([ancestors (make-vector n -1)]
         [build-ancestors
          (lambda (node)
            (cond
              [(= node 0) (vector-set! ancestors 0 (vector #f))]
              [else
               (let* ([parent (vector-ref parents node)]
                      [parent-ancestors (vector-ref ancestors parent)])
                 (cond
                   [(not parent-ancestors) (build-ancestors parent)]
                   [else
                    (let ([node-ancestors (make-vector 20 -1)])
                      (vector-set! node-ancestors 0 parent)
                      (for ([i (in-range 1 20)])
                        (let ([prev-ancestor (vector-ref node-ancestors (- i 1))])
                          (cond
                            [(< prev-ancestor 0) (vector-set! node-ancestors i -1)]
                            [else (vector-set! node-ancestors i (vector-ref ancestors prev-ancestor 0))]))))
                      (vector-set! ancestors node (vector node-ancestors))))]))))]
         [get-kth-ancestor
          (lambda (node k)
            (cond
              [(< node 0) -1]
              [(= k 0) node]
              [else
               (let* ([ancestor-table (vector-ref ancestors node 0)]
                      [power (floor (log k 2))]
                      [ancestor (vector-ref ancestor-table power)])
                 (cond
                   [(< ancestor 0) -1]
                   [else (get-kth-ancestor ancestor (- k (expt 2 power)))]))]))])
    (build-ancestors (sub1 n))
    (get-kth-ancestor node k)))