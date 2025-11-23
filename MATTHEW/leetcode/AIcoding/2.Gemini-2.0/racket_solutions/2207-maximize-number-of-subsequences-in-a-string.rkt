(define (max-number-of-subsequences text pattern)
  (define p1 (string-ref pattern 0))
  (define p2 (string-ref pattern 1))

  (define (count-subsequences s c1 c2)
    (define n (string-length s))
    (define dp (make-vector (+ n 1) 0))
    (vector-set! dp 0 1)

    (for ([i (in-range 1 (+ n 1))])
      (define char (string-ref s (- i 1)))
      (vector-set! dp i (vector-ref dp (- i 1)))
      (when (char=? char c1)
        (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i 1)))))
      (when (char=? char c2)
        (vector-set! dp i (+ (vector-ref dp i) (- (if (= i 1) 0 (vector-ref dp (- i 2))))))))

    (vector-ref dp n))

  (max (count-subsequences (string-append (string p1) text) p1 p2)
       (count-subsequences (string-append text (string p2)) p1 p2)))