#lang racket

(define (set-zeroes matrix)
  (define m (vector-length matrix))
  (when (> m 0)
    (define n (vector-length (vector-ref matrix 0)))
    (when (> n 0)
      (define row0-has-zero? #f)
      (define col0-has-zero? #f)

      ;; Check if the first row contains any zero
      (for ([j (in-range n)])
        (when (zero? (vector-ref (vector-ref matrix 0) j))
          (set! row0-has-zero? #t)))

      ;; Check if the first column contains any zero
      (for ([i (in-range m)])
        (when (zero? (vector-ref (vector-ref matrix i) 0))
          (set! col0-has-zero? #t)))

      ;; Use the first row and column as markers
      ;; If matrix[i][j] is 0, mark matrix[i][0] and matrix[0][j] as 0
      (for ([i (in-range 1 m)])
        (for ([j (in-range 1 n)])
          (when (zero? (vector-ref (vector-ref matrix i) j))
            (vector-set! (vector-ref matrix i) 0 0)
            (vector-set! (vector-ref matrix 0) j 0))))

      ;; Set elements based on the markers in the first row and column
      (for ([i (in-range 1 m)])
        (for ([j (in-range 1 n)])
          (when (or (zero? (vector-ref (vector-ref matrix i) 0))
                    (zero? (vector-ref (vector-ref matrix 0) j)))
            (vector-set! (vector-ref matrix i) j 0))))

      ;; If the first row originally had a zero, set the entire first row to zero
      (when row0-has-zero?
        (for ([j (in-range n)])
          (vector-set! (vector-ref matrix 0) j 0)))

      ;; If the first column originally had a zero, set the entire first column to zero
      (when col0-has-zero?
        (for ([i (in-range m)])
          (vector-set! (vector-ref matrix i) 0 0)))))
  matrix)