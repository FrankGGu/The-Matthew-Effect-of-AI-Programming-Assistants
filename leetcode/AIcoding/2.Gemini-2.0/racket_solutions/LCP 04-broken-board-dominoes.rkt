(provide solve)

(define solve
  (-> exact-nonnegative-integer? exact-nonnegative-integer? exact-nonnegative-integer? exact-nonnegative-integer? exact-nonnegative-integer? exact-nonnegative-integer? exact-nonnegative-integer?)
  (lambda (m n x y a b)
    (if (and (even? m) (even? n))
        (let ([holes (+ 1 (if (and (= x 0) (= y 0)) -1 0)
                      + 1 (if (and (= a 0) (= b 0)) -1 0))])
          (if (even? holes)
              #t
              #f))
        (let ([holes (+ 1 (if (and (= x 0) (= y 0)) -1 0)
                      + 1 (if (and (= a 0) (= b 0)) -1 0))])
          (if (odd? m)
              (if (odd? n)
                  (if (even? holes)
                      #t
                      #f)
                  (if (even? holes)
                      #t
                      #f))
              (if (even? holes)
                  #t
                  #f))))))