#lang racket

(define (gcd a b)
  (if (zero? b)
      a
      (gcd b (modulo a b))))

(define (find-number-of-subsequences-with-equal-gcd nums k)
  ;; Step 1: Filter nums to include only multiples of k
  (define nums-k (filter (lambda (x) (zero? (modulo x k))) nums))

  ;; If no multiples of k, no subsequence can have GCD k
  (when (empty? nums-k)
    (list 0))

  ;; Step 2: Transform nums-k to new-nums by dividing by k
  (define new-nums (map (lambda (x) (/ x k)) nums-k))

  ;; Step 3: Create a frequency array for new-nums
  ;; Find the maximum value in new-nums to size the arrays
  (define max-val-prime (if (empty? new-nums)
                            0
                            (apply max new-nums)))

  ;; If max-val-prime is 0 (meaning new-nums was empty after filtering), return 0
  (when (zero? max-val-prime)
    (list 0))

  ;; freq-arr[x] stores the count of x in new-nums
  ;; Size max-val-prime + 1 to include index 0 up to max-val-prime
  (define freq-arr (make-vector (add1 max-val-prime) 0))
  (for-each (lambda (x)
              (vector-set! freq-arr x (add1 (vector-ref freq-arr x))))
            new-nums)

  ;; Step 4: Calculate num-multiples-of-g-arr
  ;; num-multiples-of-g-arr[g] stores the count of numbers in new-nums that are multiples of g
  (define num-multiples-of-g-arr (make-vector (add1 max-val-prime) 0))
  (for-each (lambda (g)
              (let loop ((m g))
                (when (<= m max-val-prime)
                  (vector-set! num-multiples-of-g-arr g
                               (+ (vector-ref num-multiples-of-g-arr g)
                                  (vector-ref freq-arr m)))
                  (loop (+ m g)))))
            (range 1 (add1 max-val-prime)))

  ;; Step 5: Calculate dp-arr using inclusion-exclusion
  ;; dp-arr[g] stores the number of subsequences whose GCD is exactly g
  (define dp-arr (make-vector (add1 max-val-prime) 0))

  ;; Iterate g from max-val-prime down to 1
  (for (g (in-range max-val-prime 0 -1))
    (define count-g (vector-ref num-multiples-of-g-arr g))
    (when (> count-g 0)
      (define current-total-subsequences (- (expt 2 count-g) 1))
      (vector-set! dp-arr g current-total-subsequences)

      ;; Subtract dp[m*g] for m > 1
      (let loop ((m 2))
        (define mg (* m g))
        (when (<= mg max-val-prime)
          (vector-set! dp-arr g (- (vector-ref dp-arr g) (vector-ref dp-arr mg)))
          (loop (+ m 1))))))

  ;; The result is dp[1]
  (list (vector-ref dp-arr 1)))