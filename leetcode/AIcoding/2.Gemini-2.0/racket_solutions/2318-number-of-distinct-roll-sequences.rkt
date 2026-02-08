(define (distinct-roll-sequences n)
  (define mod 1000000007)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (solve n)
    (cond
      [(= n 1) 6]
      [(= n 2) 36]
      [else
       (let ([dp (make-vector n)])
         (vector-set! dp 0 6)
         (vector-set! dp 1 36)
         (for ([i (in-range 2 n)])
           (let loop ([j (in-range 1 7)])
             (for ([k (in-range 1 7)])
               (when (and (!= j k) (> 0 (gcd j k)))
                 (let ([prev-prev (if (>= (- i 2) 0) (vector-ref dp (- i 2)) 0)])
                   (vector-set! dp i (modulo (+ (vector-ref dp i 0) prev-prev) mod)))))))
         (vector-ref dp (- n 1)))]))

  (solve n))