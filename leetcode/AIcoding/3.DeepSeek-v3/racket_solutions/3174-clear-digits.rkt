(define/contract (clear-digits s)
  (-> string? string?)
  (let loop ([chars (string->list s)] [result '()])
    (cond
      [(null? chars) (list->string (reverse result))]
      [(char-numeric? (car chars)) (loop (cdr chars) (if (null? result) result (cdr result)))]
      [else (loop (cdr chars) (cons (car chars) result))])))