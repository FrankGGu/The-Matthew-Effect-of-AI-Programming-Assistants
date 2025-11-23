#lang racket

(define (maxTurbulenceSize arr)
  (define n (length arr))
  (if (< n 2) n)
  (define max-length 1)
  (define current-length 1)
  (define last-comp 0)

  (for ([i (in-range 1 n)])
    (define comp (compare (list-ref arr (- i 1)) (list-ref arr i)))
    (cond
      [(= comp 0) (set! current-length 1)]
      [(= last-comp 0) (begin (set! current-length 2) (set! last-comp comp))]
      [(= comp last-comp) (set! current-length 2) (set! last-comp comp)]
      [else (set! current-length (+ current-length 1)) (set! last-comp comp)])
    (set! max-length (max max-length current-length)))

  max-length)