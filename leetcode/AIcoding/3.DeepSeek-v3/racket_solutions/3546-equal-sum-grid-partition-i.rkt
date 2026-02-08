(define (can-partition-grid grid)
  (let* ([m (length grid)]
         [n (length (first grid))]
         [row-sums (make-vector m 0)]
         [col-sums (make-vector n 0)]
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let ([val (list-ref (list-ref grid i) j)])
          (vector-set! row-sums i (+ (vector-ref row-sums i) val))
          (vector-set! col-sums j (+ (vector-ref col-sums j) val)))))
    (let ([total (vector-foldl + 0 row-sums)])
    (if (not (zero? (modulo total 3)))
        #f
        (let ([target (/ total 3)])
          (let ([row-cuts '()]
                [col-cuts '()])
            (let loop-row ([i 0] [sum 0])
              (cond
                [(= i m) #f]
                [else
                 (set! sum (+ sum (vector-ref row-sums i)))
                 (if (= sum target)
                     (begin
                       (set! row-cuts (cons i row-cuts))
                       (if (= (length row-cuts) 2)
                           (let loop-col ([j 0] [sum 0])
                             (cond
                               [(= j n) #f]
                               [else
                                (set! sum (+ sum (vector-ref col-sums j)))
                                (if (= sum target)
                                    (begin
                                      (set! col-cuts (cons j col-cuts))
                                      (if (= (length col-cuts) 2)
                                          #t
                                          (loop-col (add1 j) 0)))
                                    (loop-col (add1 j) sum))]))
                           (loop-row (add1 i) 0)))
                     (loop-row (add1 i) sum))])))
            (let loop-col ([j 0] [sum 0])
              (cond
                [(= j n) #f]
                [else
                 (set! sum (+ sum (vector-ref col-sums j)))
                 (if (= sum target)
                     (begin
                       (set! col-cuts (cons j col-cuts))
                       (if (= (length col-cuts) 2)
                           #t
                           (loop-col (add1 j) 0)))
                     (loop-col (add1 j) sum))])))))))