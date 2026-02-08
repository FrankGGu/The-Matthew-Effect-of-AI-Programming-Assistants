(define (minimum-operations-to-write-the-letter-y grid)
  (define n (length grid))
  (define mid (quotient n 2))

  (define (is-y-cell r c)
    (if (< r mid)
        (or (= c r) (= c (- (- n 1) r)))
        (= c mid)))

  (define y-counts (make-vector 3 0))
  (define non-y-counts (make-vector 3 0))

  (for ([r (in-range n)])
    (for ([c (in-range n)])
      (define cell-val (list-ref (list-ref grid r) c))
      (if (is-y-cell r c)
          (vector-set! y-counts cell-val (+ (vector-ref y-counts cell-val) 1))
          (vector-set! non-y-counts cell-val (+ (vector-ref non-y-counts cell-val) 1)))))

  (define total-y-cells (+ (vector-ref y-counts 0) (vector-ref y-counts 1) (vector-ref y-counts 2)))
  (define total-non-y-cells (+ (vector-ref non-y-counts 0) (vector-ref non-y-counts 1) (vector-ref non-y-counts 2)))

  (define min-ops +inf.0)

  (for ([y-val (in-range 3)])
    (for ([non-y-val (in-range 3)])
      (when (not (= y-val non-y-val))
        (define current-ops
          (+ (- total-y-cells (vector-ref y-counts y-val))
             (- total-non-y-cells (vector-ref non-y-counts non-y-val))))
        (set! min-ops (min min-ops current-ops)))))

  min-ops)