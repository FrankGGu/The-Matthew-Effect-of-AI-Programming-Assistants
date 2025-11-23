#lang racket

(define (split-array-with-same-average nums)
  (let* ((N (length nums))
         (S (apply + nums)))

    ;; If N=1, it's impossible to split into two non-empty arrays.
    (when (<= N 1)
      #f)

    ;; Meet-in-the-middle strategy
    (let* ((N1 (quotient N 2))
           (N2 (- N N1))
           (nums1 (take nums N1))
           (nums2 (drop nums N1)))

      ;; compute-dp generates a vector of hash sets.
      ;; dp[k] contains all possible sums using k elements from the input array.
      (define (compute-dp arr max-len)
        (let ((dp (make-vector (+ max-len 1) (hash-set))))
          (hash-set-add! (vector-ref dp 0) 0) ; Base case: 0 elements sum to 0
          (for-each (lambda (x)
                      ;; Iterate k from max-len down to 1 to avoid using the same element multiple times
                      ;; for the same k.
                      (for k (in-range max-len 0 -1)
                        (for-each (lambda (s)
                                    (hash-set-add! (vector-ref dp k) (+ s x)))
                                  (vector-ref dp (- k 1)))))
                    arr)
          dp))

      (define dp1 (compute-dp nums1 N1))
      (define dp2 (compute-dp nums2 N2))

      ;; Check for each possible total length 'lenA' of the first subarray.
      ;; 'lenA' must be between 1 and N-1 (inclusive), because both subarrays must be non-empty.
      (for/first ([lenA (in-range 1 N)]
                  #:when (let ((target-sum-times-N (* lenA S)))
                           (and (zero? (remainder target-sum-times-N N))
                                (let ((target-sum (/ target-sum-times-N N)))
                                  ;; Iterate through possible lengths for nums1 part (lenA1)
                                  ;; lenA1 must be between max(0, lenA - N2) and min(lenA, N1)
                                  (for/first ([lenA1 (in-range (max 0 (- lenA N2)) (add1 (min lenA N1)))]
                                              #:when (let ((lenA2 (- lenA lenA1)))
                                                       ;; Check if there's a sum s1 from dp1[lenA1]
                                                       ;; and s2 from dp2[lenA2] such that s1 + s2 = target-sum
                                                       (let ((dp1-sums (vector-ref dp1 lenA1))
                                                             (dp2-sums (vector-ref dp2 lenA2)))
                                                         (for/first ([s1 (in-set dp1-sums)]
                                                                     #:when (hash-set-contains? dp2-sums (- target-sum s1)))
                                                                    #t
                                                                    #:else #f))))
                                             #t
                                             #:else #f))))
                 #t
                 #:else #f))))