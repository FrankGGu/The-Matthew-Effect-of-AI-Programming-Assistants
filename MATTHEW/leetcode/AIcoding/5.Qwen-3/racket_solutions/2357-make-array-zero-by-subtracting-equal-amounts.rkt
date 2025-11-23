(define (minimum-subtract operations)
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (+ res (car lst)))))
  (helper operations 0))