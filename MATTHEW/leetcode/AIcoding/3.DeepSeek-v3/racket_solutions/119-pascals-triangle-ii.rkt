(define (get-row rowIndex)
  (let loop ((n 0) (row '(1)))
    (if (= n rowIndex)
        row
        (loop (+ n 1) 
              (cons 1 
                    (let inner ((prev row) (res '()))
                      (if (null? (cdr prev))
                          res
                          (inner (cdr prev) (cons (+ (car prev) (cadr prev)) res)))))))