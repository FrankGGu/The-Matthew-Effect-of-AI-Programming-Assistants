(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (commonFactors a b)
  (define g (gcd a b))
  (define count 0)
  (for ([i (in-range 1 (+ 1 g))])
    (when (= (remainder g i) 0)
      (set! count (+ count 1))))
  count)