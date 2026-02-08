(define (break-palindrome palindrome)
  (let ((n (string-length palindrome)))
    (if (= n 1)
        ""
        (let loop ((i 0))
          (cond
            ((>= i (quotient n 2))
             (string-append (substring palindrome 0 (- n 1)) "a"))
            ((not (char=? (string-ref palindrome i) #\a))
             (string-append (substring palindrome 0 i) "a" (substring palindrome (+ i 1) n)))
            (else (loop (+ i 1))))))))