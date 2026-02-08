(define (restore-the-array s k)
  (define n (string-length s))
  (define MOD 1000000007)
  (define dp (make-vector (+ n 1) 0))

  (vector-set! dp n 1)

  (for ([i (range (- n 1) -1 -1)])
    (when (char=? (string-ref s i) #\0)
      ; If s[i] is '0', no valid number can start here.
      ; dp[i] remains 0 as initialized.
      )
    (unless (char=? (string-ref s i) #\0)
      (let loop ([j i] [current-val 0])
        (when (< j n)
          (define digit (- (char->integer (string-ref s j)) (char->integer #\0)))
          (define next-val (+ (* current-val 10) digit))

          (when (<= next-val k)
            (vector-set! dp i
                         (modulo (+ (vector-ref dp i) (vector-ref dp (+ j 1)))
                                 MOD))
            (loop (+ j 1) next-val))
          ))))

  (vector-ref dp 0))