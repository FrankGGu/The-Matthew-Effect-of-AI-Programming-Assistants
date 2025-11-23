(define (minimum-total triangle)
  (let ([rows (reverse triangle)])
    (car (foldl (lambda (current-row prev-processed-row)
                   (map (lambda (val prev1 prev2)
                          (+ val (min prev1 prev2)))
                        current-row
                        prev-processed-row
                        (cdr prev-processed-row)))
                 (car rows)
                 (cdr rows)))))