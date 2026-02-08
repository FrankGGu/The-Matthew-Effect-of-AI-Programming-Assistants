(define (champagne-tower poured query-row query-glass)
  ;; The maximum query_row is 99. To calculate up to query_row,
  ;; we might need to propagate from query_row to query_row + 1.
  ;; So, we need an array that can hold indices up to query_row + 1.
  ;; If query_row is 99, we need index 100. A size of 101 (0 to 100) is sufficient.
  (define tower-size 101)
  (define tower (make-vector tower-size)) ; Vector of vectors to represent the tower

  ;; Initialize the 2D array with 0.0
  (for ([i (in-range tower-size)])
    (vector-set! tower i (make-vector tower-size 0.0)))

  ;; Pour the initial amount into the top glass (0,0)
  ;; Ensure 'poured' is treated as a double-precision float for calculations
  (vector-set! (vector-ref tower 0) 0 (real->double-flonum poured))

  ;; Simulate the champagne flow
  ;; We only need to iterate up to query_row because the result for query_row
  ;; depends on values from query_row - 1, and propagation from query_row
  ;; affects query_row + 1.
  (for ([i (in-range (add1 query-row))]) ; Iterate through rows from 0 to query_row
    (for ([j (in-range (add1 i))]) ; Iterate through glasses in the current row (0 to i)
      (define current-glass-amount (vector-ref (vector-ref tower i) j))

      ;; If the current glass has more than 1 unit, the excess flows down
      (when (> current-glass-amount 1.0)
        (define excess (- current-glass-amount 1.0))
        (define half-excess (/ excess 2.0))

        ;; Add half of the excess to the glass below-left
        (let* ([next-row-vec (vector-ref tower (add1 i))]
               [current-val-left (vector-ref next-row-vec j)])
          (vector-set! next-row-vec j (+ current-val-left half-excess)))

        ;; Add half of the excess to the glass below-right
        (let* ([next-row-vec (vector-ref tower (add1 i))]
               [current-val-right (vector-ref next-row-vec (add1 j))])
          (vector-set! next-row-vec (add1 j) (+ current-val-right half-excess))))))

  ;; The amount in the target glass (query_row, query_glass)
  (define result (vector-ref (vector-ref tower query-row) query-glass))

  ;; The amount of champagne in any glass cannot exceed 1.0
  (min 1.0 result))