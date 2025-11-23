#lang racket

(define (count-mentions-per-user tweets)
  (define (process-tweet tweet)
    (define words (string-split tweet))
    (for/fold ([counts (hash)]) ([word words])
      (if (and (> (string-length word) 1)
               (char=? #\@ (string-ref word 0)))
          (hash-update counts (substring word 1) add1 0)
          counts)))
  (for/fold ([result (hash)]) ([tweet tweets])
    (hash-union result (process-tweet tweet) #:combine (lambda (a b) (+ a b)))))