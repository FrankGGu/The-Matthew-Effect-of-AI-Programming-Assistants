#lang racket

(define (concatenated-divisibility nums k)
  (define n (vector-length nums))
  (define max-mask (arithmetic-shift 1 n)) ; 2^n

  ;; Precompute the number of digits for each number in nums
  ;; and (10 ^ number-of-digits) mod k
  (define lengths (make-vector n 0))
  (define pows10 (make-vector n 0))

  (for ([i (in-range n)])
    (define num (vector-ref nums i))
    (define len
      (if (= num 0)
          1
          (add1 (floor (log10 num)))))
    (vector-set! lengths i len)

    (define current-pow 1)
    (for ([_ (in-range len)])
      (set! current-pow (remainder (* current-pow 10) k)))
    (vector-set! pows10 i current-pow))

  ;; dp[mask][remainder] is a boolean indicating if a number
  ;; formed by concatenating elements represented by 'mask'
  ;; can have 'remainder' when divided by k.
  ;; Using a vector of vectors for dp table.
  (define dp (make-vector max-mask #f))
  (for ([i (in-range max-mask)])
    (vector-set! dp i (make-vector k #f)))

  ;; Initialize dp for single numbers
  (for ([i (in-range n)])
    (define num (vector-ref nums i))
    (define rem (remainder num k))
    (vector-set! (vector-ref dp (arithmetic-shift 1 i)) rem #t))

  ;; Fill dp table using dynamic programming
  (for ([mask (in-range max-mask)])
    (for ([rem (in-range k)])
      (when (vector-ref (vector-ref dp mask) rem)
        (for ([j (in-range n)])
          ;; If nums[j] is not yet included in the current mask
          (when (= (bitwise-and mask (arithmetic-shift 1 j)) 0)
            (define new-mask (bitwise-ior mask (arithmetic-shift 1 j)))
            (define num-j (vector-ref nums j))
            (define pow10-j (vector-ref pows10 j))

            ;; Calculate the new remainder:
            ;; (current_number * 10^len(nums[j]) + nums[j]) mod k
            ;; which is equivalent to:
            ;; ( (current_remainder * (10^len(nums[j]) mod k)) + (nums[j] mod k) ) mod k
            (define new-rem (remainder (+ (remainder (* rem pow10-j) k)
                                          (remainder num-j k))
                                       k))
            (vector-set! (vector-ref dp new-mask) new-rem #t))))))

  ;; The result is true if a number formed by all elements (mask = (1 << n) - 1)
  ;; can have a remainder of 0 when divided by k.
  (vector-ref (vector-ref dp (sub1 max-mask)) 0))