#lang racket

(define (total-fruit fruits)
  (define n (vector-length fruits))
  (when (<= n 2)
    (if (zero? n)
        0
        n))

  (define fruit-counts (make-hash))
  (define left 0)
  (define max-len 0)

  (for ([right (in-range n)])
    (define current-fruit (vector-ref fruits right))

    (hash-update! fruit-counts current-fruit add1 0)

    (while (> (hash-count fruit-counts) 2)
      (define left-fruit (vector-ref fruits left))
      (hash-update! fruit-counts left-fruit sub1)
      (when (zero? (hash-ref fruit-counts left-fruit))
        (hash-remove! fruit-counts left-fruit))
      (set! left (+ left 1)))

    (set! max-len (max max-len (+ 1 (- right left)))))

  max-len)