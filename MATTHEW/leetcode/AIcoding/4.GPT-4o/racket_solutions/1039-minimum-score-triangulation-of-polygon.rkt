(define (minScoreTriangulation A)
  (define n (length A))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! dp i (make-vector n 0)))

  (for ([l (in-range 2 n)])
    (for ([i (in-range (- n l))])
      (define j (+ i l))
      (define min-score +inf.0)
      (for ([k (in-range (+ i 1) j)])
        (define score (+ (vector-ref A i) (vector-ref A j) (vector-ref A k)))
        (define total (+ (vector-ref dp i k) (vector-ref dp k j) score))
        (set! min-score (min min-score total)))
      (vector-set! dp i j min-score)))

  (vector-ref dp 0 (- n 1)))