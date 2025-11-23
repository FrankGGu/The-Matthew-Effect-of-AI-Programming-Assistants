(define (stone-game-iii stoneValue)
  (define n (length stoneValue))
  (define dp (make-vector (add1 n) #f))

  (vector-set! dp n 0)

  (for ([i (in-range (sub1 n) -1 -1)])
    (define take1 (+ (vector-ref stoneValue i) (vector-ref dp (add1 i))))
    (define take2 (if (< (add1 i) n) (+ (vector-ref stoneValue i) (vector-ref stoneValue (add1 i)) (vector-ref dp (+ i 2))) -inf.0))
    (define take3 (if (< (+ i 2) n) (+ (vector-ref stoneValue i) (vector-ref stoneValue (add1 i)) (vector-ref stoneValue (+ i 2)) (vector-ref dp (+ i 3))) -inf.0))
    (vector-set! dp i (apply max (list take1 take2 take3))))

  (if (> (vector-ref dp 0) 0)
      "Alice"
      (if (< (vector-ref dp 0) 0)
          "Bob"
          "Tie")))