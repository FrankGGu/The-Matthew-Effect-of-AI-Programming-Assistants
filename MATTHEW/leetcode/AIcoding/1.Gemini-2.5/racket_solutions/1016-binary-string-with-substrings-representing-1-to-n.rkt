(define (check-if-binary-substring s n)
  (for/all ([i (in-range 1 (+ n 1))])
    (string-contains? s (number->string i 2))))