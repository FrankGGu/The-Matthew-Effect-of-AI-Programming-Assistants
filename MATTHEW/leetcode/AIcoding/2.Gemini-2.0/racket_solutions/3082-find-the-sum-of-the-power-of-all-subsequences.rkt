(define (sum-power-subsequences nums)
  (define MOD 1000000007)
  (let loop ((nums nums) (power 0))
    (cond
      ((null? nums) power)
      (else (let ((max-num (apply max nums)))
              (loop (cdr nums) (modulo (+ (* 2 power) (* max-num max-num) (expt 2 (sub1 (length nums))) ) MOD)))))))