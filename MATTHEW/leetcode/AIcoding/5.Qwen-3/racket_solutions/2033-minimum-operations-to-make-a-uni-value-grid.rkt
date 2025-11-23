#lang racket

(define (min-operations grid)
  (define (get-median lst)
    (list-ref (sort lst <) (quotient (length lst) 2)))

  (define (get-diffs row)
    (map (lambda (x) (abs (- x (get-median row)))) row))

  (define (row-medians)
    (map get-median grid))

  (define (col-medians)
    (let* ([cols (apply map list grid)]
           [medians (map get-median cols)])
      medians))

  (define row-m (row-medians))
  (define col-m (col-medians))

  (define (sum-diffs lst m)
    (apply + (map (lambda (x) (abs (- x m))) lst)))

  (min (sum-diffs row-m (get-median row-m))
       (sum-diffs col-m (get-median col-m))))