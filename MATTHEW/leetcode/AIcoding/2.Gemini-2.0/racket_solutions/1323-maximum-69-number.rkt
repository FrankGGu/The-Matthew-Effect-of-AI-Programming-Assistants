(define (maximum69-number num)
  (string->number
   (list->string
    (let loop ([s (number->string num)] [found #f])
      (cond
        [(empty? s) s]
        [(and (not found) (equal? (string-ref s 0) #\6))
         (cons #\9 (loop (substring s 1) #t))]
        [else
         (cons (string-ref s 0) (loop (substring s 1) found))])))))