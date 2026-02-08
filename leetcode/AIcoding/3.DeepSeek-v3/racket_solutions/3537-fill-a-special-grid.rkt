(define (fill-grid grid)
  (let* ([m (length grid)]
         [n (length (first grid))]
         [result (for/list ([i (in-range m)]) 
                   (for/list ([j (in-range n)])
                     (cond
                       [(= (list-ref (list-ref grid i) j) 1) 1]
                       [(= (list-ref (list-ref grid i) j) -1) -1]
                       [else 0])))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (and (= (list-ref (list-ref grid i) j) 0)
                   (or (and (> i 0) (= (list-ref (list-ref grid (- i 1)) j) -1))
                       (and (< i (- m 1)) (= (list-ref (list-ref grid (+ i 1)) j) -1))
                       (and (> j 0) (= (list-ref (list-ref grid i) (- j 1)) -1))
                       (and (< j (- n 1)) (= (list-ref (list-ref grid i) (+ j 1)) -1))))
          (list-set! (list-ref result i) j -1))))
    result))