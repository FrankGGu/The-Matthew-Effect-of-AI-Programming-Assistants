(define (count-array-pairs-divisible-by-k nums k)
  (let* ((n (length nums))
         (counts (make-hash)))
    (for ([num nums])
      (let ((gcd-val (gcd num k)))
        (hash-update! counts gcd-val (λ (v) (+ v 1)) 1)))
    (let loop ([pairs 0]
               [gcd-vals (hash-keys counts)])
      (if (null? gcd-vals)
          pairs
          (let* ((gcd-val (car gcd-vals))
                 (count (hash-ref counts gcd-val))
                 (complementary-gcds (filter (λ (x) (zero? (modulo (* gcd-val x) k))) (hash-keys counts))))
            (let ((complementary-count
                   (foldl (λ (x acc) (+ acc (hash-ref counts x)))
                          0
                          complementary-gcds)))
              (loop (+ pairs (* count (/ complementary-count (if (member gcd-val complementary-gcds) 1 2))))
                    (cdr gcd-vals))))))))