#lang racket

(define (minimum-changes-to-make-k-semi-palindromes s k)
  (define n (string-length s))
  (define +infinity 1e9) ; Using a large number for infinity

  ;; Precompute cost[i][j]: minimum changes to make s[i..j] a semi-palindrome
  ;; cost[i][j] is a (n x n) matrix
  (define cost
    (build-vector n
                  (lambda (i)
                    (build-vector n (lambda (j) 0)))))

  (for* ([i (in-range n)]
         [j (in-range i n)])
    (define len (+ (- j i) 1))
    (when (= len 1)
      (vector-set! (vector-ref cost i) j 0))
    (unless (= len 1)
      (define min-changes-for-sub +infinity)
      ;; According to the problem statement, 'd' must be a positive integer.
      ;; Also, the index 'len(t) - 1 - x - d' must be valid (>= 0).
      ;; For all x from 0 to len/2 - 1, we need (len - 1 - x - d) >= 0.
      ;; This implies d <= len - 1 - x.
      ;; To hold for all x, d must be <= min(len - 1 - x) for x in [0, len/2 - 1].
      ;; The minimum of (len - 1 - x) occurs when x is max, i.e., x = len/2 - 1.
      ;; So, d <= len - 1 - (len/2 - 1) = len/2.
      ;; Thus, d ranges from 1 to floor(len/2).
      (for ([d (in-range 1 (add1 (quotient len 2)))]) ; d from 1 to floor(len/2)
        (define current-d-changes 0)
        (for ([x (in-range (quotient len 2))]) ; x from 0 to floor(len/2) - 1
          (define char1-idx (+ i x))
          (define char2-idx (- j x))
          (define char3-idx (- j x d)) ; This index is guaranteed to be >= i due to d <= len/2

          (when (and (not (char=? (string-ref s char1-idx) (string-ref s char2-idx)))
                     (not (char=? (string-ref s char1-idx) (string-ref s char3-idx))))
            (set! current-d-changes (+ current-d-changes 1))))
        (set! min-changes-for-sub (min min-changes-for-sub current-d-changes)))
      (vector-set! (vector-ref cost i) j min-changes-for-sub)))

  ;; dp[i][j]: min changes to partition s[0..i-1] into j semi-palindromes
  ;; dp is a (n+1 x k+1) matrix
  (define dp
    (build-vector (+ n 1)
                  (lambda (i)
                    (build-vector (+ k 1) (lambda (j) +infinity)))))

  (vector-set! (vector-ref dp 0) 0 0) ; Base case: 0 length string, 0 semi-palindromes, 0 changes

  (for ([i (in-range 1 (+ n 1))]) ; Current prefix length (exclusive end index)
    (for ([j (in-range 1 (+ k 1))]) ; Number of semi-palindromes
      (for ([p (in-range i)]) ; Previous split point (start of last semi-palindrome s[p..i-1])
        (define prev-dp-val (vector-ref (vector-ref dp p) (- j 1)))
        (unless (= prev-dp-val +infinity)
          (define current-segment-cost (vector-ref (vector-ref cost p) (- i 1)))
          (vector-set! (vector-ref dp i) j
                       (min (vector-ref (vector-ref dp i) j)
                            (+ prev-dp-val current-segment-cost)))))))

  (vector-ref (vector-ref dp n) k))