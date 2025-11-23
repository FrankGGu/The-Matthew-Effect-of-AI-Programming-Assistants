(define (matrixSum nums)
  (define (sum-column column)
    (apply + (map (lambda (row) (if (< (length row) column) 0 (list-ref row column))) nums)))
  (define max-cols (apply max (map length nums)))
  (define sums (map sum-column (range max-cols)))
  (apply + (sort sums >)))

(matrixSum '((1 2 3) (4 5 6) (7 8 9)))