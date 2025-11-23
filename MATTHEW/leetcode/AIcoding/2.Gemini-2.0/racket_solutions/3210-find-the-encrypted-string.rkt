(define (find-encrypted-string s k)
  (define n (string-length s))
  (define encrypted (make-string n #\Space))
  (define (get-index i)
    (modulo i n))

  (define (encrypt-helper i current-index step)
    (cond
      [(>= i n)
       encrypted]
      [else
       (string-set! encrypted (get-index current-index) (string-ref s i))
       (encrypt-helper (+ i 1) (+ current-index step) (+ step k))]))

  (encrypt-helper 0 0 k))