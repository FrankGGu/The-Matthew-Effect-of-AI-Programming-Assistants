#lang racket

(define (maximum-rows-covered-by-columns matrix)
  (define (count-covered rows)
    (for/sum ([row rows])
      (if (apply = row) 1 0)))
  (define (get-column-values col-index)
    (map (lambda (row) (list-ref row col-index)) matrix))
  (define (get-unique-values values)
    (remove-duplicates values))
  (define (get-coverage values)
    (for/sum ([value values])
      (count-covered (filter (lambda (row) (= (list-ref row col-index) value)) matrix))))
  (define cols (range (length (car matrix))))
  (for/fold ([max 0]) ([col cols])
    (let* ([values (get-column-values col)]
           [unique-values (get-unique-values values)]
           [coverage (get-coverage unique-values)])
      (max max coverage))))