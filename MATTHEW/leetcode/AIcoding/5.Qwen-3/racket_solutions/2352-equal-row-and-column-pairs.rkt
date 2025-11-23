#lang racket

(define (equal-row-and-column-pairs grid)
  (define rows (map (lambda (row) row) grid))
  (define cols
    (for/list ([col (in-range (length (car grid)))])
      (for/list ([row (in-list grid)])
        (list-ref row col))))
  (define count 0)
  (for ([r rows])
    (for ([c cols])
      (when (equal? r c)
        (set! count (+ count 1)))))
  count)