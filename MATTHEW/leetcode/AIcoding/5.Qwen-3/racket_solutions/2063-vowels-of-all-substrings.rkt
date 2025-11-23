#lang racket

(define (count-vowels s)
  (define vowels #(#\a #\e #\i #\o #\u))
  (define (is-vowel c)
    (member c vowels))
  (define len (string-length s))
  (define res 0)
  (for ([i (in-range len)])
    (when (is-vowel (string-ref s i))
      (set! res (+ res (+ 1 (- len i) (* i (- len i)) )))))
  res)