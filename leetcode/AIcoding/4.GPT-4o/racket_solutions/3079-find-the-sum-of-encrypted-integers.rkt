(define (encryptedSum nums)
  (define (helper n)
    (if (= n 0) 0
        (+ (modulo n 10) (helper (quotient n 10)))))
  (apply + (map helper nums)))

(encryptedSum '(123 456 789))