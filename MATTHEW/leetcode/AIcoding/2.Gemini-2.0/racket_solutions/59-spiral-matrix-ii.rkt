(define (generate-matrix n)
  (define matrix (make-vector n (make-vector n 0)))
  (define (fill-spiral row col row-end col-end num)
    (cond
      [(> row row-end) matrix]
      [else
       (for ([i (in-range col col-end)])
         (vector-set! (vector-ref matrix row) i num)
         (set! num (+ num 1)))
       (set! row (+ row 1))
       (for ([i (in-range row row-end)])
         (vector-set! (vector-ref matrix i) (- col-end 1) num)
         (set! num (+ num 1)))
       (set! col-end (- col-end 1))
       (cond
         [(> row row-end) matrix]
         [else
          (for ([i (in-range (- col-end 1) (- col 1) -1)])
            (vector-set! (vector-ref matrix (- row-end 1)) i num)
            (set! num (+ num 1)))
          (set! row-end (- row-end 1))
          (for ([i (in-range (- row-end 1) row -1)])
            (vector-set! (vector-ref matrix i) col num)
            (set! num (+ num 1)))
          (set! col (+ col 1))
          (fill-spiral row col row-end col-end num)]
         )
       ]
      ))
  (fill-spiral 0 0 n n 1))