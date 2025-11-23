(define (is-interleave s1 s2 s3)
  (define len1 (string-length s1))
  (define len2 (string-length s2))
  (define len3 (string-length s3))

  (if (!= (+ len1 len2) len3)
      #f
      (begin
        (define dp (make-vector (+ len1 1)))
        (for ([i (in-range (+ len1 1))])
          (vector-set! dp i (make-vector (+ len2 1) #f)))

        ;; dp[0][0] = #t (empty strings interleave to form an empty string)
        (vector-set! (vector-ref dp 0) 0 #t)

        ;; Fill first row (s1 is empty)
        (for ([j (in-range 1 (+ len2 1))])
          (when (and (vector-ref (vector-ref dp 0) (- j 1))
                     (char=? (string-ref s2 (- j 1)) (string-ref s3 (- j 1))))
            (vector-set! (vector-ref dp 0) j #t)))

        ;; Fill first column (s2 is empty)
        (for ([i (in-range 1 (+ len1 1))])
          (when (and (vector-ref (vector-ref dp (- i 1)) 0)
                     (char=? (string-ref s1 (- i 1)) (string-ref s3 (- i 1))))
            (vector-set! (vector-ref dp i) 0 #t)))

        ;; Fill the rest of the table
        (for ([i (in-range 1 (+ len1 1))])
          (for ([j (in-range 1 (+ len2 1))])
            (define current-s3-char (string-ref s3 (+ i j -1)))
            (define from-s1 #f)
            (define from-s2 #f)

            ;; Check if current character of s3 can come from s1
            (when (and (char=? (string-ref s1 (- i 1)) current-s3-char)
                       (vector-ref (vector-ref dp (- i 1)) j))
              (set! from-s1 #t))

            ;; Check if current character of s3 can come from s2
            (when (and (char=? (string-ref s2 (- j 1)) current-s3-char)
                       (vector-ref (vector-ref dp i) (- j 1)))
              (set! from-s2 #t))

            (vector-set! (vector-ref dp i) j (or from-s1 from-s2))))

        (vector-ref (vector-ref dp len1) len2))))