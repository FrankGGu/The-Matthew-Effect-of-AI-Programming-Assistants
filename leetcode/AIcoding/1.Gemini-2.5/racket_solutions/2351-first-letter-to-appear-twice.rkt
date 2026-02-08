#lang racket

(require racket/hash)

(define (first-repeated-character s)
  (let ([seen-chars (make-hash)])
    (for/first ([char (in-string s)])
      (if (hash-has-key? seen-chars char)
          char
          (begin
            (hash-set! seen-chars char #t)
            #f)))))