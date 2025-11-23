(define (abbreviate-product left right)
  (define (product n)
    (if (= n 1)
        1
        (* n (product (- n 1)))))
  (define total-product (product right))
  (define total-string (number->string total-product))
  (if (<= (string-length total-string) 10)
      total-string
      (string-append (substring total-string 0 1)
                     "..."
                     (substring total-string (- (string-length total-string) 3)))))

(abbreviate-product 1 5)