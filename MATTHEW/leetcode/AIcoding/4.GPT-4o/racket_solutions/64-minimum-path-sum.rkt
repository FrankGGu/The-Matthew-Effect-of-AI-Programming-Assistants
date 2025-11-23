(define (min-path-sum grid)
  (define rows (length grid))
  (define cols (length (first grid)))
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (cond
        [(= i 0) (when (> j 0) (set! (vector-ref (vector-ref grid i) j) 
                                       (+ (vector-ref (vector-ref grid i) j) 
                                          (vector-ref (vector-ref grid i) (- j 1)))))]
        [(= j 0) (when (> i 0) (set! (vector-ref (vector-ref grid i) j) 
                                       (+ (vector-ref (vector-ref grid i) j) 
                                          (vector-ref (vector-ref grid (- i 1)) j))))]
        [else (when (and (> i 0) (> j 0)) 
                (set! (vector-ref (vector-ref grid i) j) 
                      (+ (vector-ref (vector-ref grid i) j) 
                         (min (vector-ref (vector-ref grid (- i 1)) j) 
                              (vector-ref (vector-ref grid i) (- j 1)))))))])))
  (vector-ref (vector-ref grid (- rows 1)) (- cols 1)))

(define (minPathSum grid)
  (min-path-sum grid))