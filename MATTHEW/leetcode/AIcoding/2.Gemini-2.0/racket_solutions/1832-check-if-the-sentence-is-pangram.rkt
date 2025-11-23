(define (check-if-pangram sentence)
  (let ([alphabet (string->list "abcdefghijklmnopqrstuvwxyz")])
    (andmap (lambda (char) (string-contains? sentence (string char))) alphabet)))