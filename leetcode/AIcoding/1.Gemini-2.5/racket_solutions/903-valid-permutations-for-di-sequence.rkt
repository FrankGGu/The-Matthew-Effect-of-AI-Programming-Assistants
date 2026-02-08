(define (num-perms-di-sequence s n)
  (define MOD 1000000007)

  ;; dp is a vector of vectors.
  ;; dp[len] stores a vector of size 'len'.
  ;; dp[len][j] is the number of valid permutations of length 'len'
  ;; using numbers from 0 to len-1, such that the len-th element (last element)
  ;; has rank 'j' (i.e., its value is 'j').
  (define dp (make-vector (+ n 1)))

  ;; Base case: For length 1 (n=1), the only permutation is [0].
  ;; It has one element, 0, which has rank 0.
  ;; So, dp[1][0] = 1.
  (vector-set! dp 1 (make-vector 1 1))

  ;; Iterate for lengths from 2 up to n.
  (for ([len (range 2 (+ n 1))])
    ;; prev-len-dp corresponds to permutations of length 'len-1'.
    ;; Its size is 'len-1', with indices from 0 to len-2.
    (define prev-len-dp (vector-ref dp (- len 1)))

    ;; current-len-dp will store permutations of length 'len'.
    ;; Its size is 'len', with indices from 0 to len-1.
    (define current-len-dp (make-vector len 0))

    ;; The character s[len-2] determines the relation between perm[len-2] and perm[len-1].
    ;; (perm[len-2] is the last element of the previous length permutation)
    ;; (perm[len-1] is the last element of the current length permutation)
    (define char (string-ref s (- len 2)))

    (cond
      ;; If s[len-2] is 'I', then perm[len-2] < perm[len-1].
      ;; perm[len-1] has rank 'j'.
      ;; perm[len-2] must have had a rank 'k' (among 0 to len-2) such that k < j.
      ;; So, current-len-dp[j] is the sum of prev-len-dp[k] for k from 0 to j-1.
      [(= char #\I)
       (define prefix-sum 0)
       (for ([j (range len)])
         (vector-set! current-len-dp j prefix-sum)
         ;; Update prefix-sum for the next iteration.
         ;; Only add prev-len-dp[j] if j is a valid index for prev-len-dp.
         (when (< j (- len 1))
           (set! prefix-sum (modulo (+ prefix-sum (vector-ref prev-len-dp j)) MOD)))
         )]

      ;; If s[len-2] is 'D', then perm[len-2] > perm[len-1].
      ;; perm[len-1] has rank 'j'.
      ;; perm[len-2] must have had a rank 'k' (among 0 to len-2) such that k >= j.
      ;; So, current-len-dp[j] is the sum of prev-len-dp[k] for k from j to len-2.
      [(= char #\D)
       (define suffix-sum-val 0)
       ;; Iterate 'j' from len-1 down to 0.
       (for ([j (range (- len 1) -1 -1)])
         ;; Update suffix-sum-val by adding prev-len-dp[j] if j is a valid index for prev-len-dp.
         (when (<= j (- len 2))
           (set! suffix-sum-val (modulo (+ suffix-sum-val (vector-ref prev-len-dp j)) MOD)))
         (vector-set! current-len-dp j suffix-sum-val))
       ])

    ;; Store the computed current-len-dp in the dp table.
    (vector-set! dp len current-len-dp))

  ;; The final answer is the sum of all elements in dp[n].
  (define final-dp-row (vector-ref dp n))
  (define total-sum 0)
  (for ([j (range n)])
    (set! total-sum (modulo (+ total-sum (vector-ref final-dp-row j)) MOD)))

  total-sum)