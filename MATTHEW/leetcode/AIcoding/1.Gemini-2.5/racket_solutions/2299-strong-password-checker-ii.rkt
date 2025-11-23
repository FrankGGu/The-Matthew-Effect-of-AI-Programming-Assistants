(define (strong-password-checker-ii password)
  (let* ([len (string-length password)])
    (and
     ;; Rule 1: At least 8 characters
     (>= len 8)

     ;; Rule 2: Contains at least one lowercase letter
     (ormap char-lower-case? (string->list password))

     ;; Rule 3: Contains at least one uppercase letter
     (ormap char-upper-case? (string->list password))

     ;; Rule 4: Contains at least one digit
     (ormap char-numeric? (string->list password))

     ;; Rule 5: Contains at least one special character
     (let ([special-chars (list #\! #\@ #\# #\$ #\% #\^ #\& #\* #\( #\) #\- #\+)])
       (ormap (lambda (c) (member c special-chars)) (string->list password)))

     ;; Rule 6: No two adjacent characters are the same
     (if (< len 2)
         #t ; If length is 0 or 1, there are no adjacent characters.
         (for/and ([i (in-range 1 len)])
           (not (char=? (string-ref password i) (string-ref password (- i 1)))))))))