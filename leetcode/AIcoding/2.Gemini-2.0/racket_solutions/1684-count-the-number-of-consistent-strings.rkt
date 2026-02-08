(define (count-consistent-strings allowed words)
  (let ([allowed-set (string->set allowed)])
    (length
     (filter
      (lambda (word)
        (let loop ([chars (string->list word)])
          (cond
            [(null? chars) #t]
            [(set-member? (car chars) allowed-set) (loop (cdr chars))]
            [else #f])))
      words))))