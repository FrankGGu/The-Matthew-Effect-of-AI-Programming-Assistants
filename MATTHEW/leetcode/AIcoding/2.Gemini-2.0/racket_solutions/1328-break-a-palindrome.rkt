(define (break-palindrome palindrome)
  (let ((n (string-length palindrome)))
    (if (= n 1)
        ""
        (let loop ((i 0))
          (cond
            ((= i (quotient n 2))
             (string-copy palindrome 0 (- n 1) #\b)
             (string-copy palindrome (- n 1) n #\b)
             palindrome)
            ((not (equal? (string-ref palindrome i) #\a))
             (string-copy palindrome i (+ i 1) #\a)
             palindrome)
            (else
             (loop (+ i 1))))))))