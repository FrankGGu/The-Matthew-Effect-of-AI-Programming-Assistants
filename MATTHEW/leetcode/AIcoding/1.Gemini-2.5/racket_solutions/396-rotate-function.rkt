(define (max-rotate-function nums)
  (let* ([n (length nums)])
    (if (zero? n)
        0
        (let* ([sum-nums (apply + nums)]
               ;; Calculate F(0)
               [f0 (for/sum ([i (in-range n)])
                     (* i (list-ref nums i)))])
          ;; Iterate to calculate F(1) through F(n-1) using the recurrence relation:
          ;; F(k+1) = F(k) - sum(nums) + n * nums[k]
          ;; The loop variable 'i' corresponds to 'k' in nums[k].
          ;; It runs from 0 to n-2 to calculate F(1) through F(n-1).
          (for/fold ([max-f f0]        ; Accumulator for maximum F value found so far
                     [current-f f0])    ; Accumulator for F(k) in the current iteration
                    ([i (in-range (- n 1))]) ; Loop 'i' from 0 to n-2
            (let* ([next-f (+ current-f (- sum-nums) (* n (list-ref nums i)))])
              (values (max max-f next-f) next-f)))))))