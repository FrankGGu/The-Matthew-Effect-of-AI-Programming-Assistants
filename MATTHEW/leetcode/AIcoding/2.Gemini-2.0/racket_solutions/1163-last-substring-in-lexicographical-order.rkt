(define (last-substring s)
  (let loop ([i 0] [j 1] [k 0])
    (if (>= j (string-length s))
        (substring s i)
        (cond
          [(equal? (string-ref s (+ i k)) (string-ref s (+ j k)))
           (if (< (+ j k + 1) (string-length s))
               (loop i j (+ k 1))
               (substring s i))]
          [(char>? (string-ref s (+ i k)) (string-ref s (+ j k)))
           (loop i (+ j 1) 0)]
          [else
           (loop (max (+ i k 1) j) (+ (max (+ i k 1) j) 1) 0)]))))