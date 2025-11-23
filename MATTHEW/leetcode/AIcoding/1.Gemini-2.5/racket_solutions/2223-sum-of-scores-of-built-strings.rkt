#lang racket

(define (sum-scores s)
  (define n (string-length s))

  (define Z (make-vector n 0))
  (vector-set! Z 0 n)

  (define l 0)
  (define r 0)

  (define total-score n)

  (for ([i (in-range 1 n)])
    (when (<= i r)
      (vector-set! Z i (min (- r i -1) (vector-ref Z (- i l)))))

    (let loop ()
      (when (and (< (+ i (vector-ref Z i)) n)
                 (char=? (string-ref s (vector-ref Z i))
                         (string-ref s (+ i (vector-ref Z i)))))
        (vector-set! Z i (+ (vector-ref Z i) 1))
        (loop)))

    (when (> (+ i (vector-ref Z i) -1) r)
      (set! l i)
      (set! r (+ i (vector-ref Z i) -1)))

    (set! total-score (+ total-score (vector-ref Z i))))

  total-score)