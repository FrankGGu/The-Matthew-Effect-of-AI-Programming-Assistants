(define (merge-stones stones K)
  (let* ((N (vector-length stones))
         (inf +inf.0))

    ;; Prefix sums calculation
    (define prefix-sums (make-vector (+ N 1) 0))
    (for ((i (in-range N)))
      (vector-set! prefix-sums (+ i 1)
                   (+ (vector-ref prefix-sums i) (vector-ref stones i))))

    ;; Helper to get sum of stones from index i to j (inclusive)
    (define (get-sum i j)
      (- (vector-ref prefix-sums (+ j 1)) (vector-ref prefix-sums i)))

    ;; dp[i][j][m] = minimum cost to merge stones[i...j] into m piles
    ;; dp is a 3D vector: N rows, N columns, (K+1) depth
    (define dp (build-vector N (lambda (i)
                                 (build-vector N (lambda (j)
                                                  (build-vector (+ K 1) (lambda (m) inf)))))))

    ;; Base cases: dp[i][i][1] = 0 (cost to merge a single stone into 1 pile is 0)
    (for ((i (in-range N)))
      (vector-set! (vector-ref (vector-ref dp i) i) 1 0))

    ;; Iterate over segment length
    (for ((len (in-range 2 (+ N 1)))) ; len from 2 to N
      ;; Iterate over starting index of segment
      (for ((i (in-range 0 (- N len)))) ; i from 0 to N-len
        (let ((j (+ i len -1))) ; j is the ending index of segment
          ;; Calculate dp[i][j][m] for m from 2 to K
          (for ((m (in-range 2 (+ K 1)))) ; m from 2 to K (target number of piles)
            ;; Iterate over split point p
            (for ((p (in-range i j))) ; split point p from i to j-1
              (let ((cost1 (vector-ref (vector-ref (vector-ref dp i) p) 1)) ; cost to merge [i,p] into 1 pile
                    (cost2 (vector-ref (vector-ref (vector-ref dp (+ p 1)) j) (- m 1)))) ; cost to merge [p+1,j] into m-1 piles
                ;; If both subproblems are solvable
                (when (and (not (= cost1 inf)) (not (= cost2 inf)))
                  (vector-set! (vector-ref (vector-ref dp i) j) m
                               (min (vector-ref (vector-ref (vector-ref dp i) j) m)
                                    (+ cost1 cost2)))))))

          ;; After computing dp[i][j][m] for m=2..K, calculate dp[i][j][1]
          ;; This is possible only if the number of piles can be reduced to 1
          ;; which means (len - 1) must be divisible by (K - 1)
          (when (= (modulo (- len 1) (- K 1)) 0)
            (let ((cost-k-piles (vector-ref (vector-ref (vector-ref dp i) j) K)))
              ;; If it's possible to merge into K piles
              (when (not (= cost-k-piles inf))
                (vector-set! (vector-ref (vector-ref dp i) j) 1
                             (+ cost-k-piles (get-sum i j)))))))))

    ;; The final answer is the minimum cost to merge all stones (0 to N-1) into 1 pile
    (let ((final-cost (vector-ref (vector-ref (vector-ref dp 0) (- N 1)) 1)))
      (if (= final-cost inf)
          -1 ; If it's impossible, return -1
          final-cost))))