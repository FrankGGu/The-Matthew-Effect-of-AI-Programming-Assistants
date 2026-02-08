(define (longest-palindromic-subsequence s)
  (let* ((n (string-length s))
         (dp (make-vector n (lambda () (make-vector n 0))))) ; Initialize n x n DP table with 0s

    ;; Handle empty string case (though LeetCode constraints usually guarantee n >= 1)
    (when (= n 0)
      (error "Empty string provided"))

    ;; Base cases: length 1 substrings
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp i) i 1))

    ;; Fill DP table for lengths from 2 to n
    (for ([len (in-range 2 (+ n 1))]) ; len from 2 to n
      (for ([i (in-range 0 (- n len -1))]) ; i from 0 to n - len
        (let ([j (+ i len -1)])
          (if (char=? (string-ref s i) (string-ref s j))
              ;; Characters match
              (if (= len 2)
                  (vector-set! (vector-ref dp i) j 2)
                  (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1)))))
              ;; Characters don't match
              (vector-set! (vector-ref dp i) j
                           (max (vector-ref (vector-ref dp (+ i 1)) j)
                                (vector-ref (vector-ref dp i) (- j 1))))))))

    (vector-ref (vector-ref dp 0) (- n 1))))