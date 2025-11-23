(define (strong-password-checker-ii password)
  (define len (string-length password))
  (define has-lower? (regexp-match? #px"[a-z]" password))
  (define has-upper? (regexp-match? #px"[A-Z]" password))
  (define has-digit? (regexp-match? #px"[0-9]" password))
  (define has-special? (regexp-match? #px"[!@#$%^&*()\\-_=+{};:'\",.<>?]" password))
  (define has-repeated? (define (check-repeats s)
                          (let loop ((i 0) (count 1))
                            (if (>= i (- len 1))
                                #f
                                (if (char=? (string-ref s i) (string-ref s (+ i 1)))
                                    (if (>= count 2) #t (loop (+ i 1) (+ count 1)))
                                    (loop (+ i 1) 1))))))
    (has-repeated? password))

  (and (>= len 8)
       has-lower?
       has-upper?
       has-digit?
       has-special?
       (not has-repeated?)))

(define (strong-password-checker-ii-main)
  (strong-password-checker-ii "YourPasswordHere"))