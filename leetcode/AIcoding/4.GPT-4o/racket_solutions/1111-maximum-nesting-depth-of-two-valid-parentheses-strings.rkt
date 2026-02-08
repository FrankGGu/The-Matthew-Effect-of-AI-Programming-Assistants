(define (maxNestingDepth seq)
  (define (helper s depth max-depth)
    (if (null? s)
        max-depth
        (let ((char (car s)))
          (cond
            [(equal? char #\() (helper (cdr s) (+ depth 1) (max max-depth (+ depth 1)))]
            [(equal? char #\)) (helper (cdr s) (- depth 1) max-depth)]
            [else (helper (cdr s) depth max-depth)]))))
  (helper (string->list seq) 0 0))