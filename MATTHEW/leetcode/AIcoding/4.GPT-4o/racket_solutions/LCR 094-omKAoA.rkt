(define (min-cut s)
  (define n (string-length s))
  (define dp (make-vector n #f))
  (define cut (make-vector n 0))

  (for ([i (in-range n)])
    (set! (vector-ref cut i) (+ 1 i)))

  (for ([i (in-range n)])
    (for ([j (in-range i + 1)])
      (when (string=? (substring s j i) (string-reverse (substring s j i)))
        (if (= j 0)
            (set! (vector-ref dp i) 0)
            (set! (vector-ref dp i) (min (vector-ref dp i) (+ 1 (vector-ref cut (- j 1)))))))))

  (vector-ref dp (- n 1)))

(define (minCut s)
  (min-cut s))