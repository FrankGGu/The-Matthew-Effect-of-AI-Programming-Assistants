(define/contract (remove-trailing-zeros num)
  (-> string? string?)
  (let loop ([s (string->list num)])
    (cond
      [(null? s) ""]
      [(char=? (car (reverse s)) #\0) (loop (reverse (cdr (reverse s))))]
      [else (list->string s)])))