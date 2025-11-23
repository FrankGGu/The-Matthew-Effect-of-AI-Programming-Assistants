(define (kth-smallest-prime-fraction primes k)
  (define (count-less-equal frac)
    (define (helper i j count)
      (cond
        [(< i 0) count]
        [(<= (/ (list-ref primes i) (list-ref primes j)) frac)
         (helper i (- j 1) (+ count i 1))]
        [else (helper (- i 1) j count)]))
    (helper (- (length primes) 1) (- (length primes) 1) 0))

  (define (binary-search low high)
    (if (< (- high low) 1e-9)
        low
        (let ((mid (/ (+ low high) 2)))
          (if (>= (count-less-equal mid) k)
              (binary-search low mid)
              (binary-search mid high)))))

  (let ((frac (binary-search 0.0 1.0)))
    (let loop ((i 0) (j 0) (best-p 0) (best-q 1))
      (cond
        [(>= i (length primes)) (list best-p best-q)]
        [(>= j (length primes)) (loop (+ i 1) 0 best-p best-q)]
        [else
         (let ((p (list-ref primes i))
               (q (list-ref primes j)))
           (if (and (<= (/ p q) frac) (> (/ p q) (/ best-p best-q)))
               (loop i (+ j 1) p q)
               (loop i (+ j 1) best-p best-q)))]))))