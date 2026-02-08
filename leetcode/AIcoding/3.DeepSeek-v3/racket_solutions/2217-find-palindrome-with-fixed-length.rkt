(define (kth-palindrome queries k)
  (define (build-palindrome half)
    (string->number (string-append half (reverse (string->list half)))))

  (define (build-palindrome-odd half mid)
    (string->number (string-append half (string mid) (reverse (string->list half)))))

  (define (get-palindrome n)
    (let* ([half-len (quotient n 2)]
           [start (expt 10 (- half-len 1))]
           [end (expt 10 half-len)]
           [half (number->string (+ start (sub1 (quotient (sub1 n) 2))))]
           [mid (if (even? n) "" (number->string (remainder (sub1 n) 10))]))
      (if (even? n)
          (build-palindrome half)
          (build-palindrome-odd half mid))))

  (define (valid? n k)
    (let* ([min-len (if (even? k) k (+ k 1))]
           [max-len (if (even? k) k (+ k 1))])
      (and (>= n min-len) (<= n max-len))))

  (map (lambda (q)
         (if (valid? q k)
             (get-palindrome q)
             -1))
       queries))