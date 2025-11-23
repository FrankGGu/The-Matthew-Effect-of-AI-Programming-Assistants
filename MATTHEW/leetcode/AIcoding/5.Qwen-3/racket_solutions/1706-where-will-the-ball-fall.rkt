#lang racket

(define (ball-fall grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define (fall row col)
    (cond [(>= row rows) '()]
          [(or (< col 0) (>= col cols)) '()]
          [else
           (let ([next-col (+ col (list-ref (list-ref grid row) col))])
             (if (or (= next-col col) (>= next-col cols) (< next-col 0))
                 (list col)
                 (fall (+ row 1) next-col)))]))
  (map (lambda (i) (if (null? (fall 0 i)) -1 (car (fall 0 i)))) (range cols)))