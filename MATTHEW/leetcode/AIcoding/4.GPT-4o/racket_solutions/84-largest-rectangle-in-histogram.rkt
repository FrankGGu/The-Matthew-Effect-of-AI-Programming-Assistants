#lang racket

(define (largest-rectangle-in-histogram heights)
  (define n (length heights))
  (define stack '())
  (define max-area 0)

  (for ([i (in-range (+ n 1))])
    (define h (if (< i n) (list-ref heights i) 0))
    (while (and (not (null? stack)) 
                (> (car (first stack)) h))
      (define height (car (first stack)))
      (set! stack (cdr stack))
      (define width (if (null? stack) i 
                       (- i (car (first stack)))))
      (set! max-area (max max-area (* height width))))
    (set! stack (cons (list h i) stack)))

  max-area)

(define (largestRectangleArea heights)
  (largest-rectangle-in-histogram heights))