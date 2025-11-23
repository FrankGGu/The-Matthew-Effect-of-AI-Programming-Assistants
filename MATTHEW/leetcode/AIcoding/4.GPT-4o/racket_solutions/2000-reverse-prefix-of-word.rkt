(define (reverse-prefix word ch)
  (let loop ((prefix (string->list word))
             (result '())
             (found #f))
    (cond
      [(null? prefix) (list->string (append result (reverse (list->string (if found prefix '())))))]
      [(and (not found) (equal? (car prefix) ch)) (loop (cdr prefix) (cons (car prefix) result) #t)]
      [else (loop (cdr prefix) (cons (car prefix) result))])))

(define (reverse-prefix word ch)
  (let* ((idx (string-index word ch)))
    (if idx
        (string-append (list->string (reverse (string->list (substring word 0 (+ idx 1)))))
                       (substring word (+ idx 1)))
        word)))