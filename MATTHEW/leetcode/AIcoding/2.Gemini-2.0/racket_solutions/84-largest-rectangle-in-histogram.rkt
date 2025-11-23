(define (largest-rectangle-area heights)
  (let ((n (length heights)))
    (let loop ((stack '()) (i 0) (max-area 0))
      (cond
        [(and (not (empty? stack))
              (or (= i n)
                  (< (car stack) (list-ref heights (car (cdr stack))))))
         (let* ((top (car stack))
                (height (list-ref heights (car (cdr stack))))
                (width (if (empty? (cdr stack))
                           i
                           (- i (car (cdr (cdr stack))) - 1)))
                (area (* height width)))
           (loop (cdr stack) i (max (max-area area))))]
        [(= i n)
         max-area]
        [else
         (loop (cons (cons i i) stack) (add1 i) max-area)]))))