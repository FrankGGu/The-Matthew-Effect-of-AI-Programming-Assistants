#lang racket

(define (factorial n)
  (if (<= n 1) 
      1 
      (* n (factorial (- n 1)))))

(define (count-anagrams s)
  (define words (string-split s))
  (define (process-word word)
    (define freq (make-hash))
    (for ([c (in-string word)])
      (hash-update! freq c add1 0))
    (define denom 1)
    (hash-for-each freq (lambda (k v) 
                          (set! denom (* denom (factorial v)))))
    (/ (factorial (string-length word)) denom))
  (define result 1)
  (for ([word (in-list words)])
    (set! result (* result (process-word word))))
  (modulo result (expt 10 9 7)))