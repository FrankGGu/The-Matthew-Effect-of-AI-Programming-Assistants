#lang racket

(define (min-cost-triangle triangle)
  (define (helper i j)
    (cond [(= i (sub1 (length triangle))) (list-ref (last triangle) j)]
          [else
           (let ([current (list-ref (list-ref triangle i) j)])
             (cons current
                   (append (helper (add1 i) j)
                           (helper (add1 i) (add1 j)))))]))
  (apply min (map (lambda (path) (apply + path)) (helper 0 0))))