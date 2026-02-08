(define (prime-palindrome N)
  (define (prime? n)
    (cond
      ((< n 2) #f)
      ((= n 2) #t)
      ((even? n) #f)
      (else
       (let ((limit (sqrt n)))
         (let loop ((d 3))
           (cond
             ((> d limit) #t)
             ((zero? (remainder n d)) #f)
             (else (loop (+ d 2)))))))))

  (define (make-odd-palindrome x)
    (let* ((s (number->string x))
           (len (string-length s))
           (prefix-to-reverse (substring s 0 (- len 1)))
           (reversed-prefix (list->string (reverse (string->list prefix-to-reverse)))))
      (string->number (string-append s reversed-prefix))))

  (cond
    ((<= N 2) 2)
    ((<= N 3) 3)
    ((<= N 5) 5)
    ((<= N 7) 7)
    ((<= N 11) 11)
    )

  (let loop ((x 1))
    (let ((p (make-odd-palindrome x)))
      (cond
        ((and (>= p N) (prime? p)) p)
        (else (loop (+ x 1)))))))