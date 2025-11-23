(define (min-operations s)
  (define (helper s start)
    (let loop ([str (string->list s)]
               [idx 0]
               [count 0])
      (cond
        [(empty? str) count]
        [else
         (let ([expected (if (even? idx) start (if (equal? start #\0) #\1 #\0))])
           (loop (cdr str)
                 (+ idx 1)
                 (+ count (if (equal? (car str) expected) 0 1))))])))
  (min (helper s #\0) (helper s #\1)))