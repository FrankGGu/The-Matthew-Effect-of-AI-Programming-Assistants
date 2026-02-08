(define (matrix-score grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [flip-row! (lambda (row)
                      (for ([j (in-range n)])
                        (list-set! row j (- 1 (list-ref row j)))))]
         [flip-col! (lambda (col)
                      (for ([i (in-range m)])
                        (let ([row (list-ref grid i)])
                          (list-set! row col (- 1 (list-ref row col)))))]
         [count-col-ones (lambda (col)
                           (for/sum ([i (in-range m)])
                             (list-ref (list-ref grid i) col))])
    ;; Flip rows where the first element is 0
    (for ([i (in-range m)])
      (when (zero? (car (list-ref grid i)))
        (flip-row! (list-ref grid i))))
    ;; Flip columns where 0s are more than 1s
    (for ([j (in-range n)])
      (let ([ones (count-col-ones j)])
        (when (< ones (- m ones))
          (flip-col! j))))
    ;; Calculate the total score
    (for/sum ([i (in-range m)])
      (let ([row (list-ref grid i)])
        (for/sum ([j (in-range n)])
          (* (list-ref row j) (expt 2 (- n j 1))))))))