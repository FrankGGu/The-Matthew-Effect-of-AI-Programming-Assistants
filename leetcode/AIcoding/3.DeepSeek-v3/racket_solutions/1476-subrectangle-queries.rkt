#lang racket

(define subrectangle-queries%
  (class object%
    (super-new)
    (init-field [rectangle null])

    (define/public (update-subrectangle row1 col1 row2 col2 new-value)
      (for ([i (in-range row1 (add1 row2))])
        (for ([j (in-range col1 (add1 col2))])
          (vector-set! (vector-ref rectangle i) j new-value))))

    (define/public (get-value row col)
      (vector-ref (vector-ref rectangle row) col))))

(define (make-subrectangle-queries rectangle)
  (new subrectangle-queries% [rectangle (for/vector ([row rectangle])
                                          (list->vector row))]))

(define (subrectangle-queries? obj)
  (is-a? obj subrectangle-queries%))

(define (subrectangle-queries-update! obj row1 col1 row2 col2 new-value)
  (send obj update-subrectangle row1 col1 row2 col2 new-value))

(define (subrectangle-queries-get-value obj row col)
  (send obj get-value row col))