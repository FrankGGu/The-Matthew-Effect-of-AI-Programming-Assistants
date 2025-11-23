(define (longest-palindrome-subsequence-after-k-operations s k)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) -1)))

  (define (solve i j)
    (cond
      [(>= i j) 0]
      [(vector-ref (vector-ref dp i) j) (vector-ref (vector-ref dp i) j)]
      [else
       (if (char=? (string-ref s i) (string-ref s (- j 1)))
           (begin
             (vector-set! (vector-ref dp i) j (+ 2 (solve (+ i 1) (- j 1))))
             (vector-ref (vector-ref dp i) j))
           (begin
             (vector-set! (vector-ref dp i) j (max (solve (+ i 1) j) (solve i (- j 1))))
             (vector-ref (vector-ref dp i) j)))
       ]))

  (let* ((lps (solve 0 n))
         (diff (- n lps)))
    (if (>= k diff)
        n
        (+ lps k))))