(define (decode encoded first)
  (let loop ([arr (list first)]
             [prev first]
             [lst encoded])
    (if (null? lst)
        (reverse arr)
        (let ([current (bitwise-xor prev (car lst))])
          (loop (cons current arr) current (cdr lst))))))