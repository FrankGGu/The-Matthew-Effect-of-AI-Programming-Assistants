#lang racket

(define (can-form-square grid)
  (define rows (length grid))
  (define cols (if (zero? rows) 0 (string-length (car grid))))
  (define (get-color i j)
    (string-ref (list-ref grid i) j))

  (define (check-square top left size)
    (define color (get-color top left))
    (for*/and ([i (in-range top (+ top size))]
               [j (in-range left (+ left size))])
      (equal? (get-color i j) color)))

  (for*/or ([size (in-range (min rows cols) 0 -1)]
            [top (in-range 0 (- rows size -1))]
            [left (in-range 0 (- cols size -1))])
    (check-square top left size)))