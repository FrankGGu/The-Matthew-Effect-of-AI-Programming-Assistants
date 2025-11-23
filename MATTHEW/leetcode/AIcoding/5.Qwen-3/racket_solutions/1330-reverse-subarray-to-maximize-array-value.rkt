#lang racket

(define (max-array-value nums)
  (define n (length nums))
  (define-values (max-val current)
    (let loop ([i (sub1 n)] [current 0])
      (if (< i 0)
          (values current current)
          (let ([val (if (>= current (list-ref nums i))
                         (+ current (list-ref nums i))
                         (list-ref nums i))])
            (loop (sub1 i) val)))))
  max-val)