(define (countCells grid)
  (define n (length grid))
  (define m (length (car grid)))
  (define row-count (make-vector n 0))
  (define col-count (make-vector m 0))

  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (when (= (vector-ref (vector-ref grid i) j) \1)
        (vector-set! row-count i (+ 1 (vector-ref row-count i)))
        (vector-set! col-count j (+ 1 (vector-ref col-count j))))))

  (define total 0)
  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (when (= (vector-ref (vector-ref grid i) j) \1)
        (set! total (+ total (* (vector-ref row-count i) (vector-ref col-count j)))))))

  total)

(define (countCellsInOverlappingHorizontalAndVerticalSubstrings grid)
  (countCells grid))