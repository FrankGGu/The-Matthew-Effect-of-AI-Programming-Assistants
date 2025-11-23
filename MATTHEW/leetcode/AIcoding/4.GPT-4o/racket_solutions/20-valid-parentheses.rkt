(define (isValid s)
  (let loop ((s s) (stack '()))
    (cond
      [(string-empty? s) (null? stack)]
      [(or (equal? (string-ref s 0) #\() (equal? (string-ref s 0) #\[) (equal? (string-ref s 0) #\{))
       (loop (substring s 1) (cons (string-ref s 0) stack))]
      [(and (equal? (string-ref s 0) #\)) (equal? (car stack) #\() )
       (loop (substring s 1) (cdr stack))]
      [(and (equal? (string-ref s 0) #\]) (equal? (car stack) #\[))
       (loop (substring s 1) (cdr stack))]
      [(and (equal? (string-ref s 0) #\}) (equal? (car stack) #\{))
       (loop (substring s 1) (cdr stack))]
      [else #f])))