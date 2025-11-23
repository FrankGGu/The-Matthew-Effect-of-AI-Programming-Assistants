(define (number-of-great-partitions nums k)
  (define MOD 1000000007)

  (define S (foldl + 0 nums))

  (if (< S (* 2 k))
      0 ; If the total sum is less than 2k, it's impossible to have both partitions sum to at least k.
      (begin
        (define dp (make-vector (+ S 1) 0))
        (vector-set! dp 0 1) ; One way to get sum 0 (by choosing an empty subsequence)

        ;; Iterate through each number in nums
        (for ([num (in-list nums)])
          ;; Update dp array: for each sum j, we can either include num or not.
          ;; Iterate downwards to ensure each number is considered only once for forming a subsequence.
          (for ([j (in-range S num -1)])
            (vector-set! dp j
                         (modulo (+ (vector-ref dp j) (vector-ref dp (- j num))) MOD))))

        (define ans 0)
        ;; Sum up dp[i] for i from k to S-k.
        ;; These are the sums for s1 that satisfy k <= sum(s1) <= S-k.
        ;; If sum(s1) = i, then sum(s2) = S - i.
        ;; The condition sum(s2) >= k implies S - i >= k, which means i <= S - k.
        ;; So, we need to count partitions where k <= sum(s1) <= S - k.
        (for ([i (in-range k (+ S 1 (- k)))]) ; Loop from k up to S-k (inclusive)
          (set! ans (modulo (+ ans (vector-ref dp i)) MOD)))
        ans)))