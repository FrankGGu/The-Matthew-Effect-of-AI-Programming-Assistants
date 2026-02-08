(define (maximize-tower-heights n heights)
  (let* ((sorted-heights (sort heights <))
         (available-heights (let loop ((i 1) (acc '()))
                              (if (> i n)
                                  (reverse acc)
                                  (loop (+ i 1) (cons i acc))))))
    (let loop ((sh sorted-heights) (ah available-heights) (result '()))
      (cond
        [(null? sh) (apply + result)]
        [(= (car sh) (car ah)) (loop (cdr sh) (cdr ah) (cons (car sh) result))]
        [(> (car sh) (car ah)) (loop sh (cdr ah) (cons (car ah) result))]
        [else (loop (cdr sh) ah result)]))))