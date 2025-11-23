#lang racket

(define (can-construct target-words)
  (define (helper word-map word)
    (cond [(string=? word "") #t]
          [else
           (for/first ([i (in-range 1 (add1 (string-length word)))]
                      #:when (and (hash-has-key? word-map (substring word 0 i))
                                  (helper word-map (substring word i))))
             #t)
           #f]))
  (define word-map (make-hash))
  (for-each (lambda (word) (hash-set! word-map word #t)) target-words)
  (helper word-map (string-join target-words "")))