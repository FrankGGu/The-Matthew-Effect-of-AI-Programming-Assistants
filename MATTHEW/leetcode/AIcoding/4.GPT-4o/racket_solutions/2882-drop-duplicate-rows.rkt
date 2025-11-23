(define (drop-duplicate-rows rows)
  (let loop ((rows rows)
             (seen '())
             (result '()))
    (cond
      [(null? rows) (reverse result)]
      [(member (car rows) seen) (loop (cdr rows) seen result)]
      [else (loop (cdr rows) (cons (car rows) seen) (cons (car rows) result))]))))

(drop-duplicate-rows '((1 "A") (2 "B") (1 "A") (3 "C") (2 "B")))