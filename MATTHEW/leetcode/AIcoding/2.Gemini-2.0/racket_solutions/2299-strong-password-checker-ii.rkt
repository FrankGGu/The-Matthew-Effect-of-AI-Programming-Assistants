(define (strong-password? password)
  (and
   (>= (string-length password) 8)
   (regexp-match? #rx"[a-z]" password)
   (regexp-match? #rx"[A-Z]" password)
   (regexp-match? #rx"[0-9]" password)
   (regexp-match? #rx"[!@#$%^&*()-+]" password)
   (not (ormap (lambda (i) (and (< i (- (string-length password) 1)) (char=? (string-ref password i) (string-ref password (+ i 1))))) (range 0 (string-length password))))))