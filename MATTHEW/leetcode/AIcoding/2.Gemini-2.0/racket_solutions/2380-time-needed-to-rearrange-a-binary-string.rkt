(define (seconds-to-rearrange s)
  (let loop ([s (string->list s)]
             [time 0])
    (cond
      [(empty? s) time]
      [else
       (let loop2 ([lst s]
                   [new-lst '()]
                   [moved? #f])
         (cond
           [(empty? lst)
            (if moved?
                (loop (reverse new-lst) (+ time 1))
                time)]
           [(empty? (cdr lst))
            (loop2 '() (cons (car lst) new-lst) moved?)]
           [else
            (let ([first (car lst)]
                  [second (cadr lst)])
              (if (and (equal? first #\0) (equal? second #\1))
                  (loop2 (cddr lst) (cons #\0 (cons #\1 new-lst)) #t)
                  (loop2 (cdr lst) (cons first new-lst) moved?))))]))]))

(provide seconds-to-rearrange)