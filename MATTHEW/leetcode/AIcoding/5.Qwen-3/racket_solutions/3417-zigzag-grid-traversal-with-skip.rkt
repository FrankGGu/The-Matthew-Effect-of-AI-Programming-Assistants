#lang racket

(define (zigzag-grid-traversal-with-skip n skip)
  (define (helper row col direction)
    (cond [(>= row n) '()]
          [(and (= col n) (not (= direction 0))) (helper (add1 row) (sub1 col) (- direction))]
          [(and (= col -1) (not (= direction 0))) (helper (add1 row) (add1 col) (- direction))]
          [else
           (let ([current (list (add1 row) (add1 col))])
             (if (equal? current skip)
                 (helper (if (= direction 1) row (add1 row)) (if (= direction 1) (sub1 col) (add1 col)) direction)
                 (cons current (helper (if (= direction 1) row (add1 row)) (if (= direction 1) (sub1 col) (add1 col)) direction))))]))
  (helper 0 0 1))