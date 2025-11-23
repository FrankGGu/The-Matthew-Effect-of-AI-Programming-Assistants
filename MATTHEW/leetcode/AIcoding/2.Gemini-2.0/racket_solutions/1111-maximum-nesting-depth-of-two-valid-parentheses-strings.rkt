(define (max-depth-after-split seq)
  (let loop ([s (string->list seq)] [a '()] [b '()] [da 0] [db 0] [ma 0] [mb 0])
    (cond
      [(empty? s) (list ma mb)]
      [(char=? (car s) #\()
       (if (> da db)
           (loop (cdr s) a (cons (car s) b) da (+ db 1) ma (max mb (+ db 1)))
           (loop (cdr s) (cons (car s) a) b (+ da 1) db (max ma (+ da 1)) mb))]
      [else
       (if (> da db)
           (loop (cdr s) a (cons (car s) b) da (- db 1) ma mb)
           (loop (cdr s) (cons (car s) a) b (- da 1) db ma mb))])))

(define (max-nesting-depth-after-split seq)
  (let* ([depths (max-depth-after-split seq)]
         [a-depth (list-ref depths 0)]
         [b-depth (list-ref depths 1)])
    (list->string (map (lambda (c)
                          (if (> (list-ref (max-depth-after-split (string->list (string #\() #\)))) 0)
                              #\0
                              #\1))
                        (string->list seq)))))