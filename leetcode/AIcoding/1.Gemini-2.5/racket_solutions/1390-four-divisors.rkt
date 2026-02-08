(define (four-divisors nums)

  (define (get-four-divisor-sum n)
    (if (< n 6) ; Numbers less than 6 cannot have exactly four divisors (e.g., 1, 2, 3, 4, 5)
        0
        (let loop ((i 1) (count 0) (sum 0))
          (cond
            ((> (* i i) n) ; Loop termination: i has exceeded sqrt(n)
             (if (= count 4) sum 0))
            ((zero? (remainder n i)) ; i is a divisor of n
             (let* ((new-count (+ count (if (= (* i i) n) 1 2)))
                    (new-sum (+ sum i (if (= (* i i) n) 0 (quotient n i)))))
               (if (> new-count 4) ; Optimization: if count exceeds 4, it cannot be 4
                   0
                   (loop (+ i 1) new-count new-sum))))
            (else ; i is not a divisor of n
             (loop (+ i 1) count sum))))))

  (apply + (map get-four-divisor-sum nums)))