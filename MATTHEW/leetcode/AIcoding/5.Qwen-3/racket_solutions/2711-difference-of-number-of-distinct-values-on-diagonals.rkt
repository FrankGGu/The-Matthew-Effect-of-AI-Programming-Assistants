#lang racket

(define (difference-of-number-of-distinct-values-on-diagonals grid)
  (define (get-diagonal-values i j)
    (let loop ([x i] [y j] [acc '()])
      (if (or (< x 0) (>= x (length grid)) (< y 0) (>= y (length (car grid))))
          (reverse acc)
          (loop (add1 x) (sub1 y) (cons (list-ref (list-ref grid x) y) acc)))))

  (define (count-distinct lst)
    (length (remove-duplicates lst)))

  (define rows (length grid))
  (define cols (length (car grid)))
  (define result '())

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define diag1 (get-diagonal-values i j))
      (define diag2 (get-diagonal-values j i))
      (define count1 (count-distinct diag1))
      (define count2 (count-distinct diag2))
      (set! result (cons (abs (- count1 count2)) result))))

  (reverse result))