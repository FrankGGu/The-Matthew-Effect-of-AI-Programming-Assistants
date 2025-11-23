(define (max-coins nums)
  (let* ((n (length nums))
         (new-nums (make-vector (+ n 2) 1)) ; Add 1s at boundaries
         (dp (make-vector (+ n 2)))) ; DP table, vector of vectors

    ; Initialize new-nums with original values
    (for ([i (in-range n)])
      (vector-set! new-nums (+ i 1) (list-ref nums i)))

    ; Initialize dp table (vector of vectors) with zeros
    (for ([i (in-range (+ n 2))])
      (vector-set! dp i (make-vector (+ n 2) 0)))

    ; len is the length of the subproblem (j - i)
    ; len ranges from 2 (one balloon) to n+1 (all balloons)
    (for ([len (in-range 2 (+ n 2))]) ; len = j - i
      (for ([i (in-range 0 (- (+ n 2) len))]) ; i from 0 to n+2-len-1
        (let ([j (+ i len)]) ; j = i + len
          (for ([k (in-range (+ i 1) j)]) ; k from i+1 to j-1 (the last balloon to burst)
            (let* ([current-coins (+ (vector-ref (vector-ref dp i) k)
                                     (vector-ref (vector-ref dp k) j)
                                     (* (vector-ref new-nums i)
                                        (vector-ref new-nums k)
                                        (vector-ref new-nums j)))])
              (when (> current-coins (vector-ref (vector-ref dp i) j))
                (vector-set! (vector-ref dp i) j current-coins)))))))

    (vector-ref (vector-ref dp 0) (+ n 1))))