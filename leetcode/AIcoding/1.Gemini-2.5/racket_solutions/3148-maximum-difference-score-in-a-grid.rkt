(define (maximum-difference-score-in-a-grid grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define min-prefix-val (make-vector m))
  (for ([i (in-range m)])
    (vector-set! min-prefix-val i (make-vector n)))

  (define max-score -1000000001) ; Initialize with a value smaller than any possible score (1 - 10^5 = -99999).

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (define current-val (vector-ref (vector-ref grid r) c))

      (define min-val-from-top +inf.0)
      (define min-val-from-left +inf.0)

      (when (> r 0)
        (set! min-val-from-top (vector-ref (vector-ref min-prefix-val (- r 1)) c)))

      (when (> c 0)
        (set! min-val-from-left (vector-ref (vector-ref min-prefix-val r) (- c 1))))

      (define current-min-prefix current-val)
      (set! current-min-prefix (min current-min-prefix min-val-from-top))
      (set! current-min-prefix (min current-min-prefix min-val-from-left))
      (vector-set! (vector-ref min-prefix-val r) c current-min-prefix)

      (when (or (> r 0) (> c 0))
        (define min-val-for-score +inf.0)
        (set! min-val-for-score (min min-val-for-score min-val-from-top))
        (set! min-val-for-score (min min-val-for-score min-val-from-left))

        (when (< min-val-for-score +inf.0)
          (set! max-score (max max-score (- current-val min-val-for-score)))))))
  max-score)