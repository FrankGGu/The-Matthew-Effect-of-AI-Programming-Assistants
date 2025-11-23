(define (max-area-of-island grid-list)
  (let* ([rows (length grid-list)]
         [cols (if (null? grid-list) 0 (length (car grid-list)))]
         [grid (make-vector rows)])

    (when (> rows 0)
      (for ([r (in-range rows)])
        (vector-set! grid r (list->vector (list-ref grid-list r)))))

    (define (dfs r c)
      (cond
        [(or (< r 0) (>= r rows) (< c 0) (>= c cols)) 0]
        [(zero? (vector-ref (vector-ref grid r) c)) 0]
        [else
         (vector-set! (vector-ref grid r) c 0)
         (+ 1
            (dfs (+ r 1) c)
            (dfs (- r 1) c)
            (dfs r (+ c 1))
            (dfs r (- c 1)))
         ]))

    (let ([max-area 0])
      (for ([r (in-range rows)])
        (for ([c (in-range cols)])
          (when (= 1 (vector-ref (vector-ref grid r) c))
            (set! max-area (max max-area (dfs r c))))))
      max-area)))