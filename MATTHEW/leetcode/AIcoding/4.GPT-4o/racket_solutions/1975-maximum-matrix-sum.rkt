(define (maxMatrixSum matrix)
  (define total-sum 0)
  (define min-abs (apply min (map (lambda (row) (apply min (map abs row))) matrix)))
  (define negative-count (apply + (map (lambda (row) (length (filter negative? row))) matrix)))

  (for-each (lambda (row)
              (for-each (lambda (val)
                          (set! total-sum (+ total-sum (abs val))))
                        row))
            matrix)

  (if (even? negative-count)
      total-sum
      (- total-sum (* 2 min-abs))))

(maxMatrixSum '((1 -1) (-1 1)))