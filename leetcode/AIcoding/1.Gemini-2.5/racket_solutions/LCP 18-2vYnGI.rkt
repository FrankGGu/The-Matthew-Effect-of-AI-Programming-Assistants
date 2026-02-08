#lang racket

(define (breakfast-combination staple drinks x)
  (define MOD 1000000007)

  (define sorted-staple (vector-sort < (list->vector staple)))
  (define sorted-drinks (vector-sort < (list->vector drinks)))

  (define n (vector-length sorted-staple))
  (define m (vector-length sorted-drinks))

  (define total-count 0)
  (define j (- m 1))

  (for ([i (in-range n)])
    (define s (vector-ref sorted-staple i))

    (let loop ()
      (when (and (>= j 0) (> (+ s (vector-ref sorted-drinks j)) x))
        (set! j (- j 1))
        (loop)))

    (when (>= j 0)
      (set! total-count (modulo (+ total-count (+ j 1)) MOD))))

  total-count)