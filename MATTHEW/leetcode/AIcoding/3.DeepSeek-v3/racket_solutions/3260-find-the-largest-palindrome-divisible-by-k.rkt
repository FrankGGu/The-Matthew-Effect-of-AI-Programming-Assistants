(define/contract (largest-palindrome k)
  (-> exact-integer? exact-integer?)
  (let loop ([n (sub1 (expt 10 k))])
    (cond
      [(< n (expt 10 (sub1 k))) -1]
      [(let ([s (number->string n)])
         (and (equal? s (list->string (reverse (string->list s))))
              (for/or ([i (in-range (expt 10 (sub1 k)) (expt 10 k))])
                (and (zero? (modulo n i))
                     (<= (quotient n i) (sub1 (expt 10 k)))
                     (>= (quotient n i) (expt 10 (sub1 k))))))) n]
      [else (loop (sub1 n))])))