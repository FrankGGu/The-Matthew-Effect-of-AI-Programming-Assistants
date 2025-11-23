#lang racket/base

(define (max-score-grid grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dp (make-vector m #f)]) ; dp will be a vector of vectors

    ;; Initialize dp table with vectors for each row
    (for ([i (in-range m)])
      (vector-set! dp i (make-vector n 0)))

    ;; Base case: (0,0)
    (vector-set! (vector-ref dp 0) 0 (list-ref (list-ref grid 0) 0))

    ;; Fill the first row
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp 0) j
                   (+ (list-ref (list-ref grid 0) j)
                      (vector-ref (vector-ref dp 0) (- j 1)))))

    ;; Fill the first column
    (for ([i (in-range 1 m)])
      (vector-set! (vector-ref dp i) 0
                   (+ (list-ref (list-ref grid i) 0)
                      (vector-ref (vector-ref dp (- i 1)) 0))))

    ;; Fill the rest of the DP table
    (for ([i (in-range 1 m)])
      (for ([j (in-range 1 n)])
        (vector-set! (vector-ref dp i) j
                     (+ (list-ref (list-ref grid i) j)
                        (max (vector-ref (vector-ref dp (- i 1)) j)
                             (vector-ref (vector-ref dp i) (- j 1)))))))

    ;; The maximum score is at the bottom-right cell
    (vector-ref (vector-ref dp (- m 1)) (- n 1))))