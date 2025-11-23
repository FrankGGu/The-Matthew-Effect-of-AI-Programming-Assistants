#lang racket

(define (minSkips dist speed hoursBefore)
  (define n (length dist))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) (inexact->exact +inf.0))))
  (vector-set! dp 0 0)

  (for ([i (in-range n)])
    (for ([j (in-range (+ 1 i))])
      (define travel-time (ceiling (/ (vector-ref dist i) speed)))
      (define current-time (vector-ref dp j))
      (when (< current-time +inf.0)
        (vector-set! dp (+ j 1) (min (vector-ref dp (+ j 1)) (+ current-time travel-time)))))
    (for ([j (in-range (+ 1 i))])
      (define current-time (vector-ref dp j))
      (when (< current-time +inf.0)
        (vector-set! dp j (min (vector-ref dp j) (+ current-time (ceiling (/ (vector-ref dist i) speed))))))))

  (for ([j (in-range (+ 1 n))])
    (when (<= (vector-ref dp j) hoursBefore)
      (return j)))

  n)

(define (minSkips-main dist speed hoursBefore)
  (minSkips dist speed hoursBefore))