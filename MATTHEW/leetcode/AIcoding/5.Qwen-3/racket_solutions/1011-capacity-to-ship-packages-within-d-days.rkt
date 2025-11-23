(define (ship-within-days weights days)
  (define (can-ship capacity)
    (let loop ((w weights) (current-days 1) (current-weight 0))
      (cond
        [(null? w) #t]
        [(> (+ current-weight (car w)) capacity)
         (loop (cdr w) (+ current-days 1) (car w))]
        [else
         (loop (cdr w) current-days (+ current-weight (car w)))])))

  (let loop ((left (apply max weights)) (right (apply + weights)))
    (if (<= left right)
        (let ((mid (quotient (+ left right) 2)))
          (if (can-ship mid)
              (loop left (- mid 1))
              (loop (+ mid 1) right)))
        left)))