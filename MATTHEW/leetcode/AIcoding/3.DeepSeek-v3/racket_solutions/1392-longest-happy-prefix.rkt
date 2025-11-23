(define/contract (longest-prefix s)
  (-> string? string?)
  (define n (string-length s))
  (define lps (make-vector n 0))
  (define (compute-lps)
    (let loop ([len 0] [i 1])
      (cond
        [(= i n) (void)]
        [(char=? (string-ref s i) (string-ref s len))
         (vector-set! lps i (+ len 1))
         (loop (+ len 1) (+ i 1))]
        [else
         (if (zero? len)
             (begin
               (vector-set! lps i 0)
               (loop len (+ i 1)))
             (loop (vector-ref lps (- len 1)) i)]))))
  (compute-lps)
  (substring s 0 (vector-ref lps (- n 1))))