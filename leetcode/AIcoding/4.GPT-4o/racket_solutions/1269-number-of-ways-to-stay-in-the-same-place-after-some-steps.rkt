(define (numWays steps arrLen)
  (define mod 1000000007)
  (define maxPos (min arrLen (/ steps 2)))
  (define dp (make-vector (+ steps 1) (make-vector (+ 1 maxPos) 0)))
  (vector-set! dp 0 0 1)

  (for ([i (in-range 1 (+ steps 1))])
    (for ([j (in-range (+ 1 maxPos))])
      (define left (if (> j 0) (vector-ref dp (- i 1) (- j 1)) 0))
      (define right (if (< j maxPos) (vector-ref dp (- i 1) (+ j 1)) 0))
      (define stay (vector-ref dp (- i 1) j))
      (vector-set! dp i j (mod (+ left right stay) mod))))

  (vector-ref dp steps 0))

(define (numWaysWrapper steps arrLen)
  (numWays steps arrLen))