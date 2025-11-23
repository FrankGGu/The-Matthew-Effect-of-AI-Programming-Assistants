(define (is-subsequence s t)
  (cond [(null? s) #t]
        [(null? t) #f]
        [(equal? (car s) (car t)) (is-subsequence (cdr s) (cdr t))]
        [else (is-subsequence s (cdr t))]))