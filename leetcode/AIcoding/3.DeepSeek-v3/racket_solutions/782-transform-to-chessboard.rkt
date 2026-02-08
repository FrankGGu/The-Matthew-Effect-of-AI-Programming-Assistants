#lang racket

(define (moves-to-chessboard board)
  (let* ([n (length board)]
         [first-row (car board)]
         [first-col (map car board)]
         [valid-row (lambda (row) (or (equal? row first-row)
                                     (equal? row (map (lambda (x) (- 1 x)) first-row))))]
         [valid-col (lambda (col) (or (equal? col first-col)
                                     (equal? col (map (lambda (x) (- 1 x)) first-col))))])
    (if (and (andmap valid-row board)
             (andmap valid-col (apply map list board)))
        (let* ([row-swaps (min (count (lambda (x) (= x (modulo (car first-row) 2))) (range n))
                               (count (lambda (x) (not (= x (modulo (car first-row) 2)))) (range n)))]
               [col-swaps (min (count (lambda (x) (= x (modulo (caar board) 2))) (range n))
                               (count (lambda (x) (not (= x (modulo (caar board) 2)))) (range n)))]
               [total (+ row-swaps col-swaps)])
          (if (even? n)
              (min total (- n total))
              total))
        -1)))