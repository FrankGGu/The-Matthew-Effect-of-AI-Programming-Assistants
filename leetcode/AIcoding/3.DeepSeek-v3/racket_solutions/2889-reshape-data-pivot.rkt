#lang racket

(define (pivot-data df)
  (define (get-unique-values col)
    (remove-duplicates (map (lambda (row) (vector-ref row col)) df)))

  (define values-col (get-unique-values 1))
  (define id-col (get-unique-values 0))

  (define (get-value id val)
    (define result (filter (lambda (row) (and (equal? (vector-ref row 0) id)
                                             (equal? (vector-ref row 1) val)))
                           ) df))
    (if (null? result)
        null
        (vector-ref (car result) 2)))

  (define new-df (list (cons "id" values-col)))

  (for ([id id-col])
    (define row (list id))
    (for ([val values-col])
      (set! row (append row (list (get-value id val)))))
    (set! new-df (append new-df (list row))))

  (list->vector (map list->vector new-df)))