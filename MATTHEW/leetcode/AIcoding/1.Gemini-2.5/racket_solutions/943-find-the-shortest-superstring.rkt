#lang racket

(define (shortest-superstring words)
  (let* ((original-words-list words)
         (n (length original-words-list)))

    ;; Handle edge case for single word or no words
    (when (zero? n)
      (error "Input list of words cannot be empty.")) ; LeetCode constraints usually guarantee at least one word
    (when (= n 1)
      (car original-words-list))

    ;; Convert list to vector for O(1) access
    (define original-words (list->vector original-words-list))

    ;; Step 0: Remove redundant words (substrings of other words)
    (define (is-substring? s1 s2)
      (string-contains s2 s1))

    (let* ((to-keep-mask (make-vector n #t)))
      (for* ((i (in-range n))
             (j (in-range n)))
        (when (and (!= i j) (is-substring? (vector-ref original-words i) (vector-ref original-words j)))
          (vector-set! to-keep-mask i #f)))
      (set! original-words (list->vector (for/list ((i (in-range n))
                                                     #:when (vector-ref to-keep-mask i))
                                           (vector-ref original-words i))))
      (set! n (vector-length original-words)))

    ;; Handle edge cases after reduction
    (when (zero? n)
      "") ; All words were removed, e.g., ["a", "a"] -> []
    (when (= n 1)
      (vector-ref original-words 0))

    ;; Step 1: Precompute overlaps
    (define (get-overlap s1 s2)
      (let* ((len1 (string-length s1))
             (len2 (string-length s2))
             (max-overlap 0))
        (for ((i (in-range 1 (add1 (min len1 len2)))))
          (when (string=? (substring s1 (- len1 i) len1)
                          (substring s2 0 i))
            (set! max-overlap i)))
        max-overlap))

    (define overlap-matrix
      (let ((matrix (make-vector n (lambda () (make-vector n 0)))))
        (for* ((i (in-range n))
               (j (in-range n)))
          (when (!= i j)
            (vector-set! (vector-ref matrix i) j (get-overlap (vector-ref original-words i) (vector-ref original-words j)))))
        matrix))

    ;; Step 2: Dynamic Programming (TSP-like)
    ;; dp[mask][i] = maximum total overlap for a permutation of words in mask, ending with words[i]
    ;; Initialize with -1 to indicate unvisited/invalid states
    (define dp (make-vector (expt 2 n) (lambda () (make-vector n -1))))
    ;; path[mask][i] = index of the word that came before words[i] in the optimal path for mask
    (define path (make-vector (expt 2 n) (lambda () (make-vector n -1))))

    ;; Base cases: single word in mask
    (for ((i (in-range n)))
      (vector-set! (vector-ref dp (expt 2 i)) i 0)
      ;; path for a single word is -1 (no previous word)
      )

    ;; Fill DP table
    (for ((mask (in-range 1 (expt 2 n))))
      (for ((i (in-range n))) ; current last word (words[i])
        (when (not (zero? (bitwise-and mask (expt 2 i)))) ; if i is in mask
          (let ((prev-mask (bitwise-xor mask (expt 2 i))))
            (when (not (zero? prev-mask)) ; if prev-mask is not empty (i.e., mask has more than one word)
              (for ((j (in-range n))) ; previous word (words[j])
                (when (not (zero? (bitwise-and prev-mask (expt 2 j)))) ; if j is in prev-mask
                  (when (!= (vector-ref (vector-ref dp prev-mask) j) -1) ; ensure prev state is valid
                    (let ((current-overlap (+ (vector-ref (vector-ref dp prev-mask) j)
                                              (vector-ref (vector-ref overlap-matrix j) i))))
                      (when (> current-overlap (vector-ref (vector-ref dp mask) i))
                        (vector-set! (vector-ref dp mask) i current-overlap)
                        (vector-set! (vector-ref path mask) i j)))))))))))

    ;; Step 3: Find the maximum total overlap and the last word index
    (let* ((final-mask (sub1 (expt 2 n)))
           (max-total-overlap -1)
           (last-word-idx -1))
      (for ((i (in-range n)))
        (when (> (vector-ref (vector-ref dp final-mask) i) max-total-overlap)
          (set! max-total-overlap (vector-ref (vector-ref dp final-mask) i))
          (set! last-word-idx i)))

      ;; Step 4: Reconstruct the path
      (let ((ordered-indices '())
            (curr-mask final-mask)
            (curr-idx last-word-idx))
        (while (!= curr-idx -1)
          (set! ordered-indices (cons curr-idx ordered-indices))
          (let ((prev-idx (vector-ref (vector-ref path curr-mask) curr-idx)))
            (set! curr-mask (bitwise-xor curr-mask (expt 2 curr-idx)))
            (set! curr-idx prev-idx)))

        ;; Step 5: Build the superstring
        (let ((result-string (vector-ref original-words (car ordered-indices))))
          (let loop ((remaining-indices (cdr ordered-indices))
                     (prev-word-idx (car ordered-indices)))
            (if (null? remaining-indices)
                result-string
                (let* ((current-word-idx (car remaining-indices))
                       (overlap (vector-ref (vector-ref overlap-matrix prev-word-idx) current-word-idx)))
                  (set! result-string (string-append result-string
                                                     (substring (vector-ref original-words current-word-idx)
                                                                overlap
                                                                (string-length (vector-ref original-words current-word-idx)))))
                  (loop (cdr remaining-indices) current-word-idx)))))))))