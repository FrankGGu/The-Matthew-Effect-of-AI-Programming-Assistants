(define (row-with-max-ones matrix)
  (define (count-ones row)
    (foldl + 0 (map (lambda (x) (if (= x 1) 1 0)) row)))
  (define (helper matrix max-row max-count index)
    (cond [(null? matrix) max-row]
          [else
           (let ([current-count (count-ones (car matrix))])
             (if (> current-count max-count)
                 (helper (cdr matrix) index current-count (+ index 1))
                 (helper (cdr matrix) max-row max-count (+ index 1))))]))
  (helper matrix -1 0 0))