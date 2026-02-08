(define (max-dot-product nums1 nums2)
  (define n1 (length nums1))
  (define n2 (length nums2))

  ;; A sufficiently small number to represent negative infinity.
  ;; Max possible value is 500 * 1000 * 1000 = 5 * 10^8.
  ;; Min possible value is 500 * -1000 * 1000 = -5 * 10^8.
  ;; (- (expt 10 18)) is more than enough to be smaller than any valid dot product.
  (define neg-inf (- (expt 10 18)))

  ;; Initialize dp table: dp[i][j] stores the maximum dot product
  ;; using subsequences from the first i elements of nums1 and first j elements of nums2.
  ;; The table size is (n1+1) x (n2+1).
  (define dp (make-vector (+ n1 1) '()))
  (for ([i (in-range (+ n1 1))])
    (vector-set! dp i (make-vector (+ n2 1) neg-inf)))

  ;; Iterate through the DP table
  (for ([i (in-range 1 (+ n1 1))])
    (for ([j (in-range 1 (+ n2 1))])
      (define num1-val (list-ref nums1 (- i 1)))
      (define num2-val (list-ref nums2 (- j 1)))

      (define current-product (* num1-val num2-val))

      ;; Option 1: Don't use num1-val to form a pair with num2-val.
      ;; The max dot product comes from dp[i-1][j].
      (define val1 (vector-ref (vector-ref dp (- i 1)) j))

      ;; Option 2: Don't use num2-val to form a pair with num1-val.
      ;; The max dot product comes from dp[i][j-1].
      (define val2 (vector-ref (vector-ref dp i) (- j 1)))

      ;; Option 3: Use both num1-val and num2-val to form a pair.
      ;; This pair's product can either be a new subsequence's start,
      ;; or extend a previous subsequence (dp[i-1][j-1]).
      (define val3 current-product)
      (when (not (= (vector-ref (vector-ref dp (- i 1)) (- j 1)) neg-inf))
        ;; If dp[i-1][j-1] is not neg-inf, it means a valid subsequence could be formed previously.
        ;; We can either start a new subsequence with current-product, or add current-product
        ;; to the previous max dot product. Take the maximum of these two.
        (set! val3 (max val3 (+ current-product (vector-ref (vector-ref dp (- i 1)) (- j 1))))))

      ;; Update dp[i][j] with the maximum of the three options.
      (vector-set! (vector-ref dp i) j (max val1 val2 val3))))

  ;; The result is the maximum dot product using all elements up to n1 and n2.
  (vector-ref (vector-ref dp n1) n2))