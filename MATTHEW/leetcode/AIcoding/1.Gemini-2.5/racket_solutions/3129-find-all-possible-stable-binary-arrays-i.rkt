#lang racket

(define (find-all-possible-stable-binary-arrays zero one limit)
  (define MOD 1000000007)

  ;; dp[i][j][last_char][k]
  ;; i: number of zeros used
  ;; j: number of ones used
  ;; last_char: 0 for '0', 1 for '1'
  ;; k: number of consecutive 'last_char's at the end
  ;; k ranges from 1 to limit
  (define dp
    (make-vector (+ zero 1)
                 (lambda ()
                   (make-vector (+ one 1)
                                (lambda ()
                                  (make-vector 2 (lambda () (make-vector (+ limit 1) 0))))))))

  (for* ([i (in-range (+ zero 1))]
         [j (in-range (+ one 1))])

    ;; Calculate dp[i][j][0][k] (ending with '0')
    (when (> i 0)
      (let ([dp_i_j_0 (vector-ref (vector-ref (vector-ref dp i) j) 0)]
            [dp_i_minus_1_j_0 (vector-ref (vector-ref (vector-ref dp (- i 1)) j) 0)]
            [dp_i_minus_1_j_1 (vector-ref (vector-ref (vector-ref dp (- i 1)) j) 1)])
        (for ([k (in-range 1 (+ limit 1))]) ; k is consecutive zeros
          (when (<= k i) ; k cannot exceed total zeros
            (cond
              [(= k 1)
               ;; Case 1: Start a new block of '0's (previous char was '1')
               ;; Sum from dp[i-1][j][1][prev_k_ones]
               (for ([prev-k-ones (in-range 1 (+ limit 1))])
                 (when (<= prev-k-ones j) ; prev-k-ones cannot exceed total ones
                   (vector-set! dp_i_j_0 k
                                (modulo (+ (vector-ref dp_i_j_0 k)
                                           (vector-ref dp_i_minus_1_j_1 prev-k-ones))
                                        MOD))))
               ;; Base case: If j=0 and i=1, this is the array "0".
               ;; It doesn't come from a previous '1' block.
               (when (and (= i 1) (= j 0) (= k 1))
                 (vector-set! dp_i_j_0 k
                              (modulo (+ (vector-ref dp_i_j_0 k) 1) MOD)))
              ]
              [(> k 1)
               ;; Case 2: Extend a block of '0's (previous char was '0')
               ;; From dp[i-1][j][0][k-1]
               (vector-set! dp_i_j_0 k
                            (modulo (+ (vector-ref dp_i_j_0 k)
                                       (vector-ref dp_i_minus_1_j_0 (- k 1)))
                                    MOD))])))))

    ;; Calculate dp[i][j][1][k] (ending with '1')
    (when (> j 0)
      (let ([dp_i_j_1 (vector-ref (vector-ref (vector-ref dp i) j) 1)]
            [dp_i_j_minus_1_0 (vector-ref (vector-ref (vector-ref dp i) (- j 1)) 0)]
            [dp_i_j_minus_1_1 (vector-ref (vector-ref (vector-ref dp i) (- j 1)) 1)])
        (for ([k (in-range 1 (+ limit 1))]) ; k is consecutive ones
          (when (<= k j) ; k cannot exceed total ones
            (cond
              [(= k 1)
               ;; Case 1: Start a new block of '1's (previous char was '0')
               ;; Sum from dp[i][j-1][0][prev_k_zeros]
               (for ([prev-k-zeros (in-range 1 (+ limit 1))])
                 (when (<= prev-k-zeros i) ; prev-k-zeros cannot exceed total zeros
                   (vector-set! dp_i_j_1 k
                                (modulo (+ (vector-ref dp_i_j_1 k)
                                           (vector-ref dp_i_j_minus_1_0 prev-k-zeros))
                                        MOD))))
               ;; Base case: If i=0 and j=1, this is the array "1".
               (when (and (= i 0) (= j 1) (= k 1))
                 (vector-set! dp_i_j_1 k
                              (modulo (+ (vector-ref dp_i_j_1 k) 1) MOD)))
              ]
              [(> k 1)
               ;; Case 2: Extend a block of '1's (previous char was '1')
               ;; From dp[i][j-1][1][k-1]
               (vector-set! dp_i_j_1 k
                            (modulo (+ (vector-ref dp_i_j_1 k)
                                       (vector-ref dp_i_j_minus_1_1 (- k 1)))
                                    MOD))])))))

  ;; Sum up all valid final states
  (let ([total-count 0])
    (let ([final_dp_0 (vector-ref (vector-ref (vector-ref dp zero) one) 0)]
          [final_dp_1 (vector-ref (vector-ref (vector-ref dp zero) one) 1)])
      (for ([k (in-range 1 (+ limit 1))])
        (set! total-count (modulo (+ total-count (vector-ref final_dp_0 k)) MOD))
        (set! total-count (modulo (+ total-count (vector-ref final_dp_1 k)) MOD))))
    total-count))