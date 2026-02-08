(define (find-kth-bit n k)
  (define (invert s)
    (string-map (lambda (c) (if (equal? c #\0) #\1 #\0)) s))

  (define (reverse s)
    (list->string (reverse (string->list s))))

  (define (sn n)
    (if (= n 1)
        "0"
        (string-append (sn (- n 1)) "1" (invert (reverse (sn (- n 1)))))))

  (string-ref (sn n) (- k 1)))