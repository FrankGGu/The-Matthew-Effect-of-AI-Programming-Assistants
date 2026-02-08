#lang racket

(define (training-plan head)
  (define (reverse-list lst)
    (let loop ([lst lst] [acc null])
      (if (null? lst)
          acc
          (loop (cdr lst) (cons (car lst) acc)))))
  (reverse-list head))