(define (is-subsequence s t)
  (define (helper s t)
    (if (null? s)
        #t
        (if (null? t)
            #f
            (if (equal? (car s) (car t))
                (helper (cdr s) (cdr t))
                (helper s (cdr t))))))
  (helper (string->list s) (string->list t)))