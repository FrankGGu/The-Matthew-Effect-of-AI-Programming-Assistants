(define (num-decodings s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp n 1)
  (for ([i (in-range (- n 1) -1 -1)])
    (define current-char (string-ref s i))
    (cond
      [(char=? current-char #\0)
       (vector-set! dp i 0)]
      [else
       (define count (vector-ref dp (+ i 1)))
       (when (and (< i (- n 1))
                  (or (and (char=? current-char #\1)
                           (not (char=? (string-ref s (+ i 1)) #\0)))
                       (and (char=? current-char #\2)
                            (char<=? #\1 (string-ref s (+ i 1)) #\6))))
         (set! count (+ count (vector-ref dp (+ i 2)))))
       (vector-set! dp i (modulo count 1000000007))]))
  (vector-ref dp 0))