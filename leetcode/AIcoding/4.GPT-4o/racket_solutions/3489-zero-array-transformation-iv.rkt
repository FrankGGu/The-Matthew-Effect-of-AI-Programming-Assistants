(define (can-transform nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define overall-gcd (foldl gcd 0 nums))
  (define zero-count (count (lambda (x) (= x 0)) nums))
  (define non-zero-count (count (lambda (x) (not (= x 0))) nums))
  (if (and (> non-zero-count 0) (= overall-gcd 0))
      #f
      (if (or (= overall-gcd 0) (= zero-count (length nums)))
          #t
          (and (= zero-count 0) (= overall-gcd 1)))))