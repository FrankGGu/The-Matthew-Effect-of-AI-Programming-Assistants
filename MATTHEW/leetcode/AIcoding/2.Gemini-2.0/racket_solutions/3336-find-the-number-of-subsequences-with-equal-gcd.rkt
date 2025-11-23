(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (count-subsequences-with-equal-gcd nums)
  (let ([n (length nums)])
    (define (solve idx current-gcd)
      (if (= idx n)
          (if (= current-gcd 0)
              0
              1)
          (+ (solve (+ idx 1) current-gcd)
             (solve (+ idx 1) (gcd current-gcd (list-ref nums idx))))))
    (- (solve 0 0) 1)))