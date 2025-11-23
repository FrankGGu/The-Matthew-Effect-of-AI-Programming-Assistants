(define (spiral-matrix m n head)
  (define matrix (make-vector m (make-vector n 0)))

  (define (fill-spiral row-start col-start row-end col-end)
    (cond
      [(or (> row-start row-end) (> col-start col-end)) matrix]
      [else
       ; Right
       (for ([j (in-range col-start (+ col-end 1))])
         (when (not (null? head))
           (vector-set! (vector-ref matrix row-start) j (car head))
           (set! head (cdr head))))

       ; Down
       (for ([i (in-range (+ row-start 1) (+ row-end 1))])
         (when (not (null? head))
           (vector-set! (vector-ref matrix i) col-end (car head))
           (set! head (cdr head))))

       ; Left
       (when (> row-start row-end) (void))
       (when (> col-start col-end) (void))

       (for ([j (in-range (- col-end 1) (- col-start 1) -1)])
         (when (not (null? head))
           (vector-set! (vector-ref matrix row-end) j (car head))
           (set! head (cdr head))))

       ; Up
       (for ([i (in-range (- row-end 1) (+ row-start 0) -1)])
         (when (not (null? head))
           (vector-set! (vector-ref matrix i) col-start (car head))
           (set! head (cdr head))))

       (fill-spiral (+ row-start 1) (+ col-start 1) (- row-end 1) (- col-end 1))]))

  (define result (fill-spiral 0 0 (- m 1) (- n 1)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (= (vector-ref (vector-ref result i) j) 0)
        (vector-set! (vector-ref result i) j -1))))

  result)