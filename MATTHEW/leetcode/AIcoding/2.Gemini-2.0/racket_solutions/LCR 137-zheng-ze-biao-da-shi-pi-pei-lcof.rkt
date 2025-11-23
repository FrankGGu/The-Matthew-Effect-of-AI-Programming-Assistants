(define (is-subsequence s t)
  (define (helper s t si ti)
    (cond
      [(empty? s) #t]
      [(empty? t) #f]
      [(equal? (car s) (car t)) (helper (cdr s) (cdr t) (+ si 1) (+ ti 1))]
      [else (helper s (cdr t) si (+ ti 1))]))
  (helper (string->list s) (string->list t) 0 0))

(define (fuzzy-match pat str)
  (is-subsequence pat str))