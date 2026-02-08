(define (generate numRows)
  (cond
    ((= numRows 0) '())
    (else
     (let loop ((row-idx 1) (acc-result '((1))))
       (if (= row-idx numRows)
           (reverse acc-result)
           (let* ((prev-row (car acc-result)))
             (let build-current-row ((prev-tail prev-row) (current-row-elements-rev '(1)))
               (if (null? (cdr prev-tail))
                   (loop (+ row-idx 1) (cons (reverse (cons 1 current-row-elements-rev)) acc-result))
                   (build-current-row (cdr prev-tail)
                                      (cons (+ (car prev-tail) (cadr prev-tail))
                                            current-row-elements-rev))))))))))