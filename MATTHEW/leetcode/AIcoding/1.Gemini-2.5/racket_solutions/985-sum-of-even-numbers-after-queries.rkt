#lang racket

(define (sum-even-after-queries nums queries)
  (define nums-vec (list->vector nums))

  (define current-even-sum
    (for/sum ([x (in-vector nums-vec)]
              #:when (even? x))
      x))

  (define result-sums-rev '())

  (for ([query queries])
    (define val (car query))
    (define idx (cadr query))

    (define old-val (vector-ref nums-vec idx))

    (when (even? old-val)
      (set! current-even-sum (- current-even-sum old-val)))

    (define new-val (+ old-val val))
    (vector-set! nums-vec idx new-val)

    (when (even? new-val)
      (set! current-even-sum (+ current-even-sum new-val)))

    (set! result-sums-rev (cons current-even-sum result-sums-rev)))

  (reverse result-sums-rev))