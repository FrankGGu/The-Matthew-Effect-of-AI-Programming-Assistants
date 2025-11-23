#lang racket

(define (createDataFrame lst)
  (define df (make-hash))
  (for ((item lst))
    (for ((key (hash-keys item)))
      (define values (hash-ref df key '()))
      (hash-set! df key (cons (hash-ref item key) values))))
  df)

(define (createDataFrameFromList lst)
  (map createDataFrame lst))