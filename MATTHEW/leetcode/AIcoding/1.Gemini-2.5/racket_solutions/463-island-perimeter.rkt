(define (island-perimeter grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))
  (define total-perimeter 0)

  (for* ([i (in-range m)]
         [j (in-range n)])
    (when (= (vector-ref (vector-ref grid i) j) 1)
      (define current-cell-perimeter 4)

      (when (and (> i 0) (= (vector-ref (vector-ref grid (- i 1)) j) 1))
        (set! current-cell-perimeter (- current-cell-perimeter 1)))
      (when (and (< i (- m 1)) (= (vector-ref (vector-ref grid (+ i 1)) j) 1))
        (set! current-cell-perimeter (- current-cell-perimeter 1)))
      (when (and (> j 0) (= (vector-ref (vector-ref grid i) (- j 1)) 1))
        (set! current-cell-perimeter (- current-cell-perimeter 1)))
      (when (and (< j (- n 1)) (= (vector-ref (vector-ref grid i) (+ j 1)) 1))
        (set! current-cell-perimeter (- current-cell-perimeter 1)))

      (set! total-perimeter (+ total-perimeter current-cell-perimeter))))

  total-perimeter)