(define/contract (add-spaces s spaces)
  (-> string? (listof exact-integer?) string?)
  (let loop ([s (string->list s)]
              [spaces (sort spaces <)]
              [i 0]
              [result '()])
    (cond
      [(null? s) (list->string (reverse result))]
      [(and (not (null? spaces)) (= i (car spaces)))
       (loop s (cdr spaces) i (cons #\space result))]
      [else
       (loop (cdr s) spaces (+ i 1) (cons (car s) result))])))