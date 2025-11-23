#lang racket

(define (find-rotation mat target)
  (define (rotate m)
    (reverse (apply map list m)))
  (let loop ([m mat] [count 0])
    (cond
      [(equal? m target) #t]
      [(= count 3) #f]
      [else (loop (rotate m) (add1 count))])))