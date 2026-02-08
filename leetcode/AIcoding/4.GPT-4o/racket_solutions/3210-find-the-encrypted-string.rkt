(define (encrypt-string s)
  (define (helper s n)
    (if (null? s)
        ""
        (let* ((mid (quotient (length s) 2))
               (ch (string-ref s mid))
               (left (substring s 0 mid))
               (right (substring s (+ mid 1))))
          (string-append (string ch) (helper right (+ n 1)) (helper left (+ n 1))))))
  (helper s 0))

(define (find-encrypted-string s)
  (encrypt-string s))