(define (generate numRows)
  (cond
    [(= numRows 0) '()]
    [(= numRows 1) '((1))]
    [else
     (let loop ([rows '((1))] [n 1])
       (if (= n numRows)
           (reverse rows)
           (let* ([prev-row (car rows)]
                  [new-row (append '(1)
                                   (map (lambda (x y) (+ x y))
                                        (cdr prev-row)
                                        (reverse (cdr (reverse prev-row)))))
                                   '(1))])
             (loop (cons new-row rows) (add1 n)))))]))