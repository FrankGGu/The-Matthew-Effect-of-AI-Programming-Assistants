#lang racket

(define (count-negative grid)
  (define (count-row row)
    (define (helper i count)
      (if (>= i (length row))
          count
          (if (< (list-ref row i) 0)
              (helper (+ i 1) (+ count 1))
              (helper (+ i 1) count))))
    (helper 0 0))
  (define (helper i count)
    (if (>= i (length grid))
        count
        (helper (+ i 1) (+ count (count-row (list-ref grid i))))))
  (helper 0 0))