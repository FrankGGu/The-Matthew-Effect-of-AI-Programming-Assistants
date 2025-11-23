(define (fill-special-grid m n)
  (define dp (make-vector m #f)) ; Initialize rows

  ; Create the grid and initialize all cells to 0
  (for ([i (in-range m)])
    (vector-set! dp i (make-vector n 0)))

  ; Base cases: first row and first column have 1 way to reach each cell
  (for ([j (in-range n)])
    (vector-set! (vector-ref dp 0) j 1))

  (for ([i (in-range m)])
    (vector-set! (vector-ref dp i) 0 1))

  ; Fill the rest of the grid using dynamic programming
  ; Each cell (i, j) represents the number of unique paths from (0,0) to (i,j)
  ; by moving only right or down.
  (for ([i (in-range 1 m)])
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp i) j
                   (+ (vector-ref (vector-ref dp (- i 1)) j) ; Paths from above
                      (vector-ref (vector-ref dp i) (- j 1)))))) ; Paths from left
  dp)