(define (maxScore grid operations)
  (define (sum-grid grid)
    (apply + (apply append grid)))

  (define (apply-operations grid ops)
    (for-each (lambda (op)
                (define i (car op))
                (define j (cadr op))
                (for-each (lambda (row)
                            (when (< j (length row))
                              (set! (vector-ref row j) (+ (vector-ref row j) 1))))
                          grid))
              ops)
    grid)

  (define updated-grid (apply-operations (map (lambda (row) (vector->list row)) grid) operations))
  (sum-grid updated-grid))

(maxScore #2A((1 2) (3 4)) '((0 0) (1 1) (0 1)))