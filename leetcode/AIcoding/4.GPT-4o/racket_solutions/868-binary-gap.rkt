(define (binary-gap n)
  (define (max-gap bits)
    (define (helper bits prev max-gap)
      (cond
        [(null? bits) max-gap]
        [(equal? (car bits) 1) (if (null? prev)
                                    (helper (cdr bits) (car bits) max-gap)
                                    (helper (cdr bits) (car bits) (max max-gap (- (length bits) (length (cdr bits)) 1)))]
        [else (helper (cdr bits) prev max-gap)]))
    (helper bits #f 0))
  (max-gap (map (lambda (x) (string->number (string x))) (string->list (number->string (bitwise-and n (sub1 (expt 2 (add1 (integer-length n))))))))))
)

(define (binaryGap n)
  (binary-gap n))