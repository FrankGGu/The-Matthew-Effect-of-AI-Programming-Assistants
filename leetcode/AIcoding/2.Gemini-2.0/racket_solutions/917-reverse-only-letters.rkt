(define (reverse-only-letters s)
  (define letters (filter char-alphabetic? (string->list s)))
  (define reversed-letters (reverse letters))
  (define (helper s idx letters-idx)
    (cond
      [(empty? s) '()]
      [(char-alphabetic? (car s))
       (cons (list-ref reversed-letters letters-idx) (helper (cdr s) idx (+ letters-idx 1)))]
      [else (cons (car s) (helper (cdr s) idx letters-idx))]))
  (list->string (helper (string->list s) 0 0)))