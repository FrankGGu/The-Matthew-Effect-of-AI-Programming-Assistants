(define (surface-area grid)
  (define (get-val row col)
    (if (and (>= row 0) (< row (vector-length grid)) (>= col 0) (< col (vector-length (vector-ref grid 0)))))
        (vector-ref (vector-ref grid row) col)
        0))

  (define (calculate-area)
    (let loop ([row 0] [col 0] [total-area 0])
      (if (= row (vector-length grid))
          total-area
          (let ([current-val (vector-ref (vector-ref grid row) col)])
            (let ([new-total-area (+ total-area
                                      (if (> current-val 0) (+ (* 2 current-val)) 0)
                                      (abs (- current-val (get-val (sub1 row) col)))
                                      (abs (- current-val (get-val (add1 row) col)))
                                      (abs (- current-val (get-val row (sub1 col))))
                                      (abs (- current-val (get-val row (add1 col))))
                                      )])
              (if (= col (sub1 (vector-length (vector-ref grid 0)))))
                  (loop (add1 row) 0 new-total-area)
                  (loop row (add1 col) new-total-area)))))))

  (calculate-area))