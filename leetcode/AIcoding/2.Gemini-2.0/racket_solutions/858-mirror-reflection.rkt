(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (mirror-reflection p q)
  (let* ((g (gcd p q))
         (pp (/ p g))
         (qq (/ q g)))
    (cond
      [(even? pp) 2]
      [(even? qq) 0]
      [else 1])))