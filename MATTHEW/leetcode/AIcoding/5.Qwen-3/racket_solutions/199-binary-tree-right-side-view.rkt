#lang racket

(define (right-side-view root)
  (define (bfs level node)
    (cond [(null? node) '()]
          [else
           (let ([current (car node)]
                 [next (cdr node)])
             (if (null? next)
                 (cons (car current) (bfs '() '()))
                 (cons (car current) (bfs (append next (list (cadr current) (caddr current))) '()))))]))
  (bfs '() (list root)))