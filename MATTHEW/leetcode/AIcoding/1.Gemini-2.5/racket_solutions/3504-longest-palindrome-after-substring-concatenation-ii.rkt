(define (longest-palindromic-subsequence s)
  (let* ((n (string-length s)))
    (if (= n 0) 0
        (let ((dp (build-vector n (lambda (i) (build-vector n (lambda (j) 0))))))

          ;; Initialize dp for single characters
          (for ([i (in-range n)])
            (vector-set! (vector-ref dp i) i 1))

          ;; Fill dp table for lengths from 2 to n
          ;; i goes from n-len down to 0, j = i + len - 1
          ;; This ensures that dp[i+1][j-1], dp[i+1][j], dp[i][j-1] are already computed.
          (for ([len (in-range 2 (+ n 1))])
            (for ([i (in-range (- n len) -1 -1)])
              (let ([j (+ i len -1)])
                (cond
                  ((char=? (string-ref s i) (string-ref s j))
                   (let ([val (if (= len 2) 2 (+ 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1)))))])
                     (vector-set! (vector-ref dp i) j val)))
                  (else
                   (let ([val (max (vector-ref (vector-ref dp (+ i 1)) j)
                                   (vector-ref (vector-ref dp i) (- j 1)))])
                     (vector-set! (vector-ref dp i) j val)))))))
          (vector-ref (vector-ref dp 0) (- n 1))))))

(define (longest-palindrome-after-substring-concatenation-ii s1 s2)
  (let* ((s1+s2 (string-append s1 s2))
         (s2+s1 (string-append s2 s1)))
    (max (longest-palindromic-subsequence s1+s2)
         (longest-palindromic-subsequence s2+s1))))