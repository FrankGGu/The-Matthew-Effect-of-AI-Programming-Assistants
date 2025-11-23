(define (can-jump stones)
  (define n (length stones))
  (define dp (make-vector n #f))
  (vector-set! dp 0 #t)

  (define (jump k)
    (for ((i (in-range n)))
      (if (vector-ref dp i)
          (for ((j (in-range (max 1 (- k 1)) (+ k 2))))
            (define next (+ i j))
            (when (and (< next n) (= (vector-ref stones next) (+ (vector-ref stones i) j)))
              (vector-set! dp next #t)))))

  (for ((k (in-range 1 n)))
    (jump k))

  (vector-ref dp (sub1 n)))

(define (canCross stones)
  (if (null? stones)
      #f
      (can-jump stones)))