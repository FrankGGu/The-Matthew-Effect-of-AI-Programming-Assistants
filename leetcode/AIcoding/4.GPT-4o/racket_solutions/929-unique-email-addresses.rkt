(define (numUniqueEmails emails)
  (define (normalize email)
    (let* ([parts (string-split email "@" #f)]
           [local (car parts)]
           [domain (cadr parts)]
           [local (string-replace local "+" "")]
           [local (string-replace local "." "")]
           [normalized (string-append local "@" domain)])
      normalized))
  (define unique-emails (make-hash))
  (for-each (lambda (email)
              (hash-set! unique-emails (normalize email) #t))
            emails)
  (hash-count unique-emails))

(numUniqueEmails '("test.email+alex@leetcode.com" "test.e.mail+bob@leetcode.com" "testemail@leetcode.com"))