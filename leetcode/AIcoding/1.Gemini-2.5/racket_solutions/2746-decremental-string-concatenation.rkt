#lang racket

(define +inf.0 (expt 10 9)) ; A sufficiently large number representing infinity

(define (calculate-max-overlap s1 s2)
  (let* ([len1 (string-length s1)]
         [len2 (string-length s2)]
         [max-k (min len1 len2)])
    (let loop ([k max-k])
      (cond
        [(= k 0) 0]
        [(string=? (substring s1 (- len1 k) len1) (substring s2 0 k)) k]
        [else (loop (- k 1))]))))

(define (minimize-concatenation-length words)
  (let* ([n (length words)]
         [max-mask (arithmetic-shift 1 n)] ; 2^n, representing all possible subsets of words
         ;; dp[mask][last_idx] stores the minimum length for the set of words in 'mask',
         ;; with the last concatenated word being words[last_idx].
         [dp (make-vector max-mask (lambda () (make-vector n +inf.0)))]
         [word-lengths (map string-length words)]
         ;; overlaps[i][j] stores the maximum overlap between words[i] (suffix) and words[j] (prefix).
         [overlaps (make-vector n (lambda () (make-vector n 0)))])

    ;; Precompute all necessary overlaps between pairs of words.
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (not (= i j)) ; Overlap with self is not relevant for concatenation
          (vector-set! (vector-ref overlaps i) j
                       (calculate-max-overlap (list-ref words i) (list-ref words j))))))

    ;; Initialize base cases: A single word forms a string of its own length.
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp (arithmetic-shift 1 i)) i (list-ref word-lengths i)))

    ;; Fill the DP table using bitmask DP.
    ;; Iterate through all possible masks (subsets of words), from smallest to largest.
    (for ([mask (in-range 1 max-mask)])
      ;; Iterate through each word 'i' that could be the last word in the current mask.
      (for ([i (in-range n)])
        ;; Check if word 'i' is part of the current 'mask' and if dp[mask][i] is reachable (not +inf.0).
        (when (and (not (= (vector-ref (vector-ref dp mask) i) +inf.0))
                   (not (zero? (bit-and mask (arithmetic-shift 1 i)))))
          ;; Iterate through each word 'j' that could be added next to the current sequence.
          (for ([j (in-range n)])
            ;; If word 'j' is not yet in the current 'mask' (i.e., it's a new word to add).
            (when (zero? (bit-and mask (arithmetic-shift 1 j)))
              (let* ([next-mask (bit-ior mask (arithmetic-shift 1 j))] ; New mask with word 'j' included
                     [current-len (vector-ref (vector-ref dp mask) i)]
                     [overlap-ij (vector-ref (vector-ref overlaps i) j)]
                     [word-j-len (list-ref word-lengths j)]
                     ;; Calculate the new length: current length + length of new word - overlap.
                     [new-len (+ current-len word-j-len (- overlap-ij))])
                ;; Update dp[next-mask][j] if a shorter path is found.
                (when (< new-len (vector-ref (vector-ref dp next-mask) j))
                  (vector-set! (vector-ref dp next-mask) j new-len))))))))

    ;; After filling the DP table, find the minimum length among all states
    ;; where all words are used (represented by the 'final-mask').
    (let ([final-mask (- max-mask 1)]) ; Mask where all bits are set (all words used)
      (let loop ([min-total-len +inf.0]
                 [i 0])
        (cond
          [(= i n) min-total-len]
          [else (loop (min min-total-len (vector-ref (vector-ref dp final-mask) i))
                      (+ i 1))])))))