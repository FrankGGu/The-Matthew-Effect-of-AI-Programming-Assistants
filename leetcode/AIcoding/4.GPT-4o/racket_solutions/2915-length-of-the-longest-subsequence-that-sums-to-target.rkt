(define (lengthOfLongestSubsequence nums target)
  (define n (length nums))
  (define dp (make-vector (+ target 1) 0))

  (for ([i (in-range n)])
    (for ([j (in-range target (vector-length dp) -1)])
      (when (>= j (vector-ref nums i))
        (vector-set! dp j (max (vector-ref dp j) (+ 1 (vector-ref dp (- j (vector-ref nums i)))))))))

  (vector-ref dp target))

(lengthOfLongestSubsequence '(1 2 3 4 5) 5)