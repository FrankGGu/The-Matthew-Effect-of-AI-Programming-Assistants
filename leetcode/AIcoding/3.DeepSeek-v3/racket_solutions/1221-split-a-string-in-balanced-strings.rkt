(define (balanced-string-split s)
  (let loop ([chars (string->list s)]
             [count 0]
             [result 0])
    (if (null? chars)
        result
        (let ([new-count (if (char=? (car chars) #\L)
                             (add1 count)
                             (sub1 count))])
          (loop (cdr chars)
                new-count
                (if (zero? new-count)
                    (add1 result)
                    result))))))