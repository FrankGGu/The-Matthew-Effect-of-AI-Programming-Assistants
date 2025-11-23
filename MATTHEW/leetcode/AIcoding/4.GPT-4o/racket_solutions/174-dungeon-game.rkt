(define (calculateMinimumHP dungeon)
  (define rows (length dungeon))
  (define cols (length (car dungeon)))
  (define dp (make-vector (+ rows 1) (make-vector (+ cols 1) 0)))

  (for ((i (in-range (+ 1 rows))))
    (vector-set! dp i (make-vector (+ cols 1) 0)))

  (vector-set! dp rows cols 1)

  (for ((i (in-range (- rows 1) -1 -1)))
    (for ((j (in-range (- cols 1) -1 -1)))
      (if (and (= i (- rows 1)) (= j (- cols 1)))
          (vector-set! dp i j (max 1 (- 1 (vector-ref (vector-ref dungeon i) j))))
          (begin
            (define down (if (= i (- rows 1)) +inf.0 (vector-ref dp (+ i 1) j)))
            (define right (if (= j (- cols 1)) +inf.0 (vector-ref dp i (+ j 1))))
            (vector-set! dp i j (max 1 (- (min down right) (vector-ref (vector-ref dungeon i) j))))))))

  (vector-ref dp 0 0))