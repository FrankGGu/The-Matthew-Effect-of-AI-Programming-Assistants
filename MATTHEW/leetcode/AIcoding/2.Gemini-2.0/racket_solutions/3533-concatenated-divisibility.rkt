(define (concatenated-divisibility nums k)
  (let loop ([nums nums] [result #t])
    (cond
      [(null? nums) result]
      [else
       (let ([current-num (car nums)]
             [concatenated-num (string->number (string-append (number->string k) (number->string current-num)))])
         (if (zero? (modulo concatenated-num k))
             (loop (cdr nums) result)
             (loop (cdr nums) #f)))])))