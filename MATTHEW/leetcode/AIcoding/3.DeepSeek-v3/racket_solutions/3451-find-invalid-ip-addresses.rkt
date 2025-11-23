(define (restore-ip-addresses s)
  (define (valid? s)
    (and (<= (string-length s) 3)
         (if (> (string-length s) 1)
             (and (not (char=? (string-ref s 0) #\0))
             #t)
         (<= (string->number s) 255)))

  (define (helper s k)
    (cond
      [(= k 0) (if (string=? s "") '(()) '())]
      [else
       (for*/list ([i (in-range 1 (min 4 (add1 (string-length s))))]
                   [part (in-value (substring s 0 i))]
                   [rest (in-value (substring s i))]
         #:when (valid? part)
         (for/list ([ip (helper rest (sub1 k))])
           (cons part ip)))]))

  (define (combine parts)
    (string-join parts "."))

  (map combine (helper s 4)))