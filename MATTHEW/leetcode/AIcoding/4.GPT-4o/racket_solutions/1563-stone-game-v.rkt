(define (stoneGameV stoneValue)
  (define n (length stoneValue))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! dp i i (vector-ref stoneValue i)))

  (for* ([l (in-range 1 n)]
         [i (in-range (- n l))])
    (define j (+ i l))
    (for ([k (in-range i j)])
      (define left (vector-sum stoneValue i (add1 k)))
      (define right (vector-sum stoneValue (add1 k) j))
      (define score (max left right))
      (vector-set! dp i j (max (vector-ref dp i j) 
                                (if (<= left right) 
                                    left 
                                    right))))
      ))

  (vector-ref dp 0 (sub1 n)))

(define (vector-sum vec start end)
  (foldl + 0 (subvector vec start end)))