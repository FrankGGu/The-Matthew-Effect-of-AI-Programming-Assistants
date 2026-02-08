#lang racket

(require math/matrix)

(define (max-grid-score grid)
  (define m (matrix-num-rows grid))
  (define n (matrix-num-cols grid))
  (define dp (make-matrix m n -inf.0))
  (matrix-set! dp (- m 1) (- n 1) (matrix-ref grid (- m 1) (- n 1)))

  (for ([i (in-range (- m 1) -1 -1)])
    (for ([j (in-range (- n 1) -1 -1)])
      (unless (and (= i (- m 1)) (= j (- n 1)))
        (define right (if (< j (- n 1)) (matrix-ref dp i (+ j 1)) -inf.0))
        (define down (if (< i (- m 1)) (matrix-ref dp (+ i 1) j) -inf.0))
        (matrix-set! dp i j (+ (matrix-ref grid i j) (max right down)))))

  (matrix-ref dp 0 0))