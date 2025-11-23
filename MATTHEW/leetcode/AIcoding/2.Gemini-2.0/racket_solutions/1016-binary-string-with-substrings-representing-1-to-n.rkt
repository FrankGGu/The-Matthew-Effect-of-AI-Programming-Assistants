(define (solve s n)
  (for/and ([i (in-range 1 (+ n 1))])
    (string-contains? s (number->string i #:base 2))))

(define (string-contains? s sub)
  (if (string<=? (string-length s) (string-length sub))
      (equal? s sub)
      (or (string=? (substring s 0 (string-length sub)) sub)
          (string-contains? (substring s 1) sub))))

(define (queryString s n)
  (solve s n))