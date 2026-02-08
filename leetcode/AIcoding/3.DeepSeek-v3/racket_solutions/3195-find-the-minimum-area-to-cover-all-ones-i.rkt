(define/contract (min-area grid k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [ones (for*/list ([i (in-range rows)]
                           [j (in-range cols)]
                           #:when (= (list-ref (list-ref grid i) j) 1))
                 (cons i j))])
    (if (< (length ones) k)
        0
        (let ([min-area +inf.0])
          (for* ([i1 (in-range rows)]
                 [j1 (in-range cols)]
                 [i2 (in-range i1 rows)]
                 [j2 (in-range j1 cols)])
            (let ([cnt (count (lambda (p)
                                (let ([x (car p)]
                                      [y (cdr p)])
                                (and (>= x i1) (<= x i2) (>= y j1) (<= y j2)))
                              ones)])
              (when (>= cnt k)
                (set! min-area (min min-area (* (add1 (- i2 i1)) (add1 (- j2 j1))))))))
          (if (= min-area +inf.0) 0 min-area)))))