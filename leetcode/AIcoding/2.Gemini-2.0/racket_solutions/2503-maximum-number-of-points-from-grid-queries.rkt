(define (max-points grid queries)
  (let* ([m (vector-length grid)]
         [n (vector-length (vector-ref grid 0))]
         [points (make-vector (length queries) 0)]
         [indexed-queries (map (lambda (q i) (list q i)) queries (range (length queries)))]
         [sorted-queries (sort indexed-queries < #:key car)]
         [visited (make-vector m (make-vector n #f))]
         [heap (make-heap <)])
    (vector-set! visited 0 (make-vector n #f))
    (vector-set! (vector-ref visited 0) 0 #t)
    (heap-add! heap (list (vector-ref (vector-ref grid 0) 0) 0 0))
    (let loop ([i 0] [points points] [heap heap] [visited visited])
      (if (>= i (length queries))
          points
          (let* ([query (car (list-ref sorted-queries i))]
                 [query-index (cadr (list-ref sorted-queries i))])
            (let loop2 ([points points] [heap heap] [visited visited] [count 0])
              (if (heap-empty? heap)
                  (vector-set! points query-index count)
                  (let* ([min-val (heap-top heap)]
                         [value (car min-val)]
                         [row (cadr min-val)]
                         [col (caddr min-val)])
                    (if (>= value query)
                        (begin
                          (vector-set! points query-index count)
                          (loop (+ i 1) points heap visited))
                        (begin
                          (heap-remove-top! heap)
                          (let* ([neighbors (list (list (+ row 1) col)
                                                 (list (- row 1) col)
                                                 (list row (+ col 1))
                                                 (list row (- col 1)))]
                                 [valid-neighbors
                                  (filter (lambda (neighbor)
                                            (let ([r (car neighbor)]
                                                  [c (cadr neighbor)])
                                              (and (>= r 0) (< r m)
                                                   (>= c 0) (< c n)
                                                   (not (vector-ref (vector-ref visited r) c)))))
                                          neighbors)])
                            (for-each (lambda (neighbor)
                                        (let ([r (car neighbor)]
                                              [c (cadr neighbor)])
                                          (vector-set! (vector-ref visited r) c #t)
                                          (heap-add! heap (list (vector-ref (vector-ref grid r) c) r c))))
                                      valid-neighbors)
                          (loop2 points heap visited (+ count 1)))))))))))))