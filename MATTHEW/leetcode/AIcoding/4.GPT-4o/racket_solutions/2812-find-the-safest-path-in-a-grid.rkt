#lang racket

(define (findSafestPath grid)
  (define rows (length grid))
  (define cols (length (first grid)))
  (define dp (make-vector rows (lambda () (make-vector cols +inf.0))))

  (vector-set! dp 0 (make-vector cols +inf.0))
  (vector-set! (vector-ref dp 0) 0 (vector-ref (vector-ref grid 0) 0))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (and (zero? i) (zero? j))
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref grid i) j)))
      (when (> i 0)
        (define up (vector-ref (vector-ref dp (- i 1)) j))
        (define current (vector-ref (vector-ref grid i) j))
        (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp i) j) (+ up current))))
      (when (> j 0)
        (define left (vector-ref (vector-ref dp i) (- j 1)))
        (define current (vector-ref (vector-ref grid i) j))
        (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp i) j) (+ left current))))))

  (define safest-path (vector-ref (vector-ref dp (- rows 1)) (- cols 1)))
  safest-path)

(define (minPathSum grid)
  (findSafestPath grid))