(define/contract (make-fancy-string s)
  (-> string? string?)
  (define lst (string->list s))
  (define (helper lst prev count acc)
    (cond
      [(null? lst) (list->string (reverse acc))]
      [(equal? (car lst) prev)
       (if (>= count 2)
           (helper (cdr lst) prev count acc)
           (helper (cdr lst) prev (+ count 1) (cons (car lst) acc)))]
      [else
       (helper (cdr lst) (car lst) 1 (cons (car lst) acc))]))
  (if (null? lst) "" (helper (cdr lst) (car lst) 1 (list (car lst)))))