(define/contract (validate-book-sequence pushed popped)
  (-> (listof exact-integer?) (listof exact-integer?) boolean?)
  (let loop ([stack '()] [pushed pushed] [popped popped])
    (cond
      [(and (null? pushed) (null? popped) (null? stack)) #t]
      [(and (not (null? stack)) (not (null? popped)) (equal? (car stack) (car popped)))
       (loop (cdr stack) pushed (cdr popped))]
      [(not (null? pushed))
       (loop (cons (car pushed) stack) (cdr pushed) popped)]
      [else #f])))