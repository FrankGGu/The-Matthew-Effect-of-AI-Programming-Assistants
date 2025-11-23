#lang racket

(define (min-deletions s k)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define counts (sort (hash-values freq) >))
  (define len (string-length s))
  (define target (floor (/ len k)))
  (define res 0)
  (for ([count counts])
    (when (> count target)
      (set! res (+ res (- count target)))))
  res)