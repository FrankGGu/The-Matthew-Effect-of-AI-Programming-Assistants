#lang racket

(define (halves-are-alike s)
  (define vowels #(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define len (string-length s))
  (define mid (quotient len 2))
  (define (count-vowels str)
    (for/sum ([c str])
      (if (member c vowels) 1 0)))
  (= (count-vowels (substring s 0 mid))
     (count-vowels (substring s mid len))))