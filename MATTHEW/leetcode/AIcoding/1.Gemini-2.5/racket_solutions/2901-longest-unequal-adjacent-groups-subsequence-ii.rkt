#lang racket

(define (longest-unequal-adjacent-groups-subsequence-ii strengths hps)
  (define n (length strengths))

  (define dp (make-vector n 1)) ; dp[i] = length of the longest subsequence ending at index i
  (define prev (make-vector n -1)) ; prev[i] = index of the previous element in the longest subsequence ending at i

  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (let ([s_i (list-ref strengths i)]
            [h_i (list-ref hps i)]
            [s_j (list-ref strengths j)]
            [h_j (list-ref hps j)])
        ; Check if group j and group i are unequal
        (when (or (not (= s_i s_j)) (not (= h_i h_j)))
          ; If extending the subsequence ending at j with i results in a longer subsequence
          (when (> (+ (vector-ref dp j) 1) (vector-ref dp i))
            (vector-set! dp i (+ (vector-ref dp j) 1))
            (vector-set! prev i j))))))

  (define max-len 0)
  (define end-idx -1)

  ; Find the maximum length and the index where it ends
  (for ([i (in-range n)])
    (when (> (vector-ref dp i) max-len)
      (set! max-len (vector-ref dp i))
      (set! end-idx i)))

  ; Reconstruct the subsequence
  (define result '())
  (define current-idx end-idx)
  (while (not (= current-idx -1))
    (set! result (cons current-idx result)) ; Prepend current index to build the list in correct order
    (set! current-idx (vector-ref prev current-idx)))

  result)