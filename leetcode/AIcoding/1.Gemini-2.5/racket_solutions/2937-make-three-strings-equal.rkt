(define (minimum-operations s1 s2 s3)
  (let* ([len1 (string-length s1)]
         [len2 (string-length s2)]
         [len3 (string-length s3)]
         [min-overall-len (min len1 len2 len3)])
    (let loop ([i 0])
      (cond
        [(= i min-overall-len)
         (if (= i 0)
             -1
             (+ (- len1 i) (- len2 i) (- len3 i)))]
        [(and (char=? (string-ref s1 i) (string-ref s2 i))
              (char=? (string-ref s2 i) (string-ref s3 i)))
         (loop (+ i 1))]
        [else
         (if (= i 0)
             -1
             (+ (- len1 i) (- len2 i) (- len3 i)))]))))