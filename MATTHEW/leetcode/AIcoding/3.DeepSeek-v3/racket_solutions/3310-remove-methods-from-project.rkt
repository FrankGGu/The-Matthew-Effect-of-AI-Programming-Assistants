#lang racket

(define (remove-methods project)
  (let loop ([proj project]
             [result '()])
    (cond
      [(null? proj) (reverse result)]
      [(and (pair? (car proj)) (eq? (caar proj) 'method))
       (loop (cdr proj) result)]
      [else (loop (cdr proj) (cons (car proj) result))])))