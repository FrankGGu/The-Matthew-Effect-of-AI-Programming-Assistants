(define (maxNiceDivisors n)
  (define (mod-exp base exp mod)
    (if (= exp 0)
        1
        (define half (mod-exp base (quotient exp 2) mod))
        (if (even? exp)
            (mod (* half half) mod)
            (mod (* base (mod (* half half) mod)) mod))))

  (define mod 1000000007)
  (if (<= n 3)
      n
      (let* ((x (if (zero? (mod n 3)) (/ n 3) (if (= (mod n 3) 1) (- (/ n 3) 1) (/ n 3))))
                 (y (if (= (mod n 3) 1) 4 3))
                 (count (if (= (mod n 3) 1) 1 (if (= (mod n 3) 2) 2 0))))
        (mod (* (mod-exp y x mod) (mod-exp 2 count mod)) mod))))

(maxNiceDivisors n)