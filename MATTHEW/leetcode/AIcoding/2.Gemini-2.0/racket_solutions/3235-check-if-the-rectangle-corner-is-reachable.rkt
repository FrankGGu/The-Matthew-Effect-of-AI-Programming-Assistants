(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (is-rectangle-corner-reachable height width)
  (if (or (= height 1) (= width 1))
      #t
      (= (gcd height width) 1)))