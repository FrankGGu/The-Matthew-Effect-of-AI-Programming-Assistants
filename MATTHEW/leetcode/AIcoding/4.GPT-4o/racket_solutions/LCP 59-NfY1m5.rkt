(define (can-cross stones)
  (define n (length stones))
  (define dp (make-vector n #f))
  (vector-set! dp 0 (make-vector n #f))
  (vector-set! (vector-ref dp 0) 0 #t)

  (define (jump k i)
    (for ([j (in-range (- i k) (+ i k 1))])
      (when (and (>= j 0) (< j n) (vector-ref (vector-ref dp j) (sub1 k)))
        (vector-set! (vector-ref dp j) k #t))))

  (for ([i (in-range 1 n)])
    (for ([k (in-range n)])
      (when (vector-ref (vector-ref dp (- i 1)) k)
        (jump (+ k 1) i)
        (jump k i)
        (jump (- k 1) i))))

  (for ([i (in-range n)])
    (when (vector-ref (vector-ref dp (- n 1)) i)
      (return #t)))

  #f)

(define (canCross stones)
  (can-cross stones))