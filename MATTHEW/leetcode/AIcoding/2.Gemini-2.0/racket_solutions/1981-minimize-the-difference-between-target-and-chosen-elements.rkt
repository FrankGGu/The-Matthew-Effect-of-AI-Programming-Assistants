(define (minimize-the-difference target mat)
  (define m (length mat))
  (define n (length (car mat)))

  (define (solve row current-sum)
    (cond
      [(= row m) (abs (- current-sum target))]
      [else (let loop ([col 0] [min-diff +inf.0])
              (cond
                [(= col n) min-diff]
                [else (let ([new-diff (solve (+ row 1) (+ current-sum (list-ref (list-ref mat row) col)))])
                        (loop (+ col 1) (min min-diff new-diff)))]))]))

  (solve 0 0))