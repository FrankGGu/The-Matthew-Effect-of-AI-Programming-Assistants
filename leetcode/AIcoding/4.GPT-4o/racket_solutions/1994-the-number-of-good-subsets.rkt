(define (number-of-good-subsets nums)
  (define MOD 1000000007)
  (define freq (make-vector 31 0))
  (for-each (lambda (x) (vector-set! freq x (+ 1 (vector-ref freq x)))) nums)

  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define prime-factors
    (list 2 3 5 7 11 13 17 19 23 29))

  (define (is-good-subset subset)
    (define g (foldl gcd 0 subset))
    (= g 1))

  (define (count-subsets current prime-index)
    (if (= prime-index (length prime-factors))
        (if (is-good-subset (map (lambda (i) (if (> (vector-ref freq i) 0) i)) (range 31)))
            1
            0)
        (+ (count-subsets current (+ prime-index 1))
           (if (> (vector-ref freq (list-ref prime-factors prime-index)) 0)
               (count-subsets (cons (list-ref prime-factors prime-index) current) (+ prime-index 1))
               0))))

  (define total-good-subsets (count-subsets '() 0))
  (modulo (- total-good-subsets 1) MOD))

(number-of-good-subsets '(1 2 3 4 5 6 7 8 9 10))