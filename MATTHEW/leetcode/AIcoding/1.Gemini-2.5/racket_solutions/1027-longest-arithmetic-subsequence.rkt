(define (longest-arith-seq nums)
  (define n (length nums))

  (when (<= n 1)
    (if (= n 0) 0 1)) ; Handle n=0 or n=1 explicitly, though problem states n >= 1

  (define dp (make-vector n)) ; dp[i] will be a hash table mapping diff -> length

  ;; Initialize each element of dp with an empty hash table
  (for ([i (in-range n)])
    (vector-set! dp i (make-hash)))

  (define max-len 1) ; Minimum length of an arithmetic subsequence is 1 (a single element)

  (for ([i (in-range n)])
    (define num-i (list-ref nums i))
    (for ([j (in-range i)])
      (define num-j (list-ref nums j))
      (define diff (- num-i num-j))

      ;; Length of arithmetic subsequence ending at j with this diff
      ;; If diff is not found in dp[j], it means nums[j] itself starts a new sequence of length 1
      (define prev-len (hash-ref (vector-ref dp j) diff 1))

      ;; New length for the subsequence ending at i with this diff
      (define new-len (+ prev-len 1))

      ;; Get the current length stored for this diff at index i, defaulting to 1 (nums[i] itself)
      (define current-val-at-i (hash-ref (vector-ref dp i) diff 1))

      ;; Update dp[i] with the maximum length found for this diff
      (define updated-len (max current-val-at-i new-len))
      (hash-set! (vector-ref dp i) diff updated-len)

      ;; Update overall maximum length
      (set! max-len (max max-len updated-len))
      )))
  max-len)