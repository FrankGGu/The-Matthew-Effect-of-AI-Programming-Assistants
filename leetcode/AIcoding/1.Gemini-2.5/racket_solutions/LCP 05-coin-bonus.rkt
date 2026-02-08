#lang racket

(define (coin-bonus nums)
  (if (null? nums)
      0
      (let* ([max-val (apply max nums)]
             [counts (make-vector (+ max-val 1) 0)])
        ;; Populate counts
        (for-each (lambda (num)
                    (vector-set! counts num (+ (vector-ref counts num) 1)))
                  nums)

        (let ([dp (make-vector (+ max-val 1) 0)])
          ;; Base cases
          ;; dp[0] is 0 by default (make-vector initializes with 0)
          ;; For i=1, if we take 1s, we get counts[1]*1.
          ;; Since problem constraints typically have nums[i] >= 1, max-val will be >= 1 if nums is not empty.
          (vector-set! dp 1 (* (vector-ref counts 1) 1))

          ;; DP iteration
          (for ([i (in-range 2 (+ max-val 1))])
            (let* ([points-at-i (* (vector-ref counts i) i)]
                   [take-i (+ (vector-ref dp (- i 2)) points-at-i)]
                   [skip-i (vector-ref dp (- i 1))])
              (vector-set! dp i (max take-i skip-i))))

          (vector-ref dp max-val)))))