(define SubrectangleQueries
  (class object%
    (super-new)
    (define/override (initialize rectangle)
      (set! this-rectangle rectangle))

    (define this-rectangle '())

    (define (update-rectangle row1 col1 row2 col2 new-value)
      (for ([i (in-range row1 (+ row2 1))])
        (for ([j (in-range col1 (+ col2 1))])
          (set! (list-ref (list-ref this-rectangle i) j) new-value))))

    (define (get-value row col)
      (list-ref (list-ref this-rectangle row) col))

    (define/public (updateSubrectangle row1 col1 row2 col2 newValue)
      (update-rectangle row1 col1 row2 col2 newValue))

    (define/public (getValue row col)
      (get-value row col))
  ))