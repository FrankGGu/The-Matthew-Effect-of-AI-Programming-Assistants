(define (sum-k-mirror-numbers n k)
  (define (is-palindrome-base10? num)
    (let ((s (number->string num)))
      (string=? s (string-reverse s))))

  (define (to-base-k num base)
    (if (= num 0)
        '(0)
        (let loop ((n num) (digits '()))
          (if (= n 0)
              digits
              (loop (quotient n base) (cons (remainder n base) digits))))))

  (define (list-palindrome? lst)
    (equal? lst (reverse lst)))

  (define (is-palindrome-basek? num base)
    (list-palindrome? (to-base-k num base)))

  (let loop ((current-num 1) (found-count 0) (total-sum 0))
    (if (= found-count n)
        total-sum
        (if (and (is-palindrome-base10? current-num)
                 (is-palindrome-basek? current-num k))
            (loop (+ current-num 1) (+ found-count 1) (+ total-sum current-num))
            (loop (+ current-num 1) found-count total-sum)))))