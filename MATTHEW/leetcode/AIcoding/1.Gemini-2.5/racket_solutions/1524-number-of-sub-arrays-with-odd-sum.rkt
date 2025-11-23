(define (num-subarrays-with-odd-sum arr)
  (define MOD 1000000007)

  (let loop ((nums arr)
             (ans 0)
             (current-sum-parity 0) ; 0 for even, 1 for odd
             (even-prefix-sums 1)   ; Count of prefix sums that are even (including P[0]=0)
             (odd-prefix-sums 0))   ; Count of prefix sums that are odd
    (if (empty? nums)
        ans
        (let* ((x (car nums))
               (new-current-sum-parity (modulo (+ current-sum-parity x) 2)))
          (if (= new-current-sum-parity 1) ; The new prefix sum is odd
              (loop (cdr nums)
                    (modulo (+ ans even-prefix-sums) MOD)
                    new-current-sum-parity
                    even-prefix-sums
                    (add1 odd-prefix-sums))
              ; The new prefix sum is even
              (loop (cdr nums)
                    (modulo (+ ans odd-prefix-sums) MOD)
                    new-current-sum-parity
                    (add1 even-prefix-sums)
                    odd-prefix-sums))))))