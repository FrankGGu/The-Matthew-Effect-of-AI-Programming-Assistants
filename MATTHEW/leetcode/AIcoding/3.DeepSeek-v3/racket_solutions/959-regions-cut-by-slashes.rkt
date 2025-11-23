(define (regions-by-slashes grid)
  (let* ([n (length grid)]
         [size (* 3 n)]
         [g (make-vector (* size size) 0)])
    (for ([row (in-range n)])
      (for ([col (in-range n)])
        (let ([c (string-ref (list-ref grid row) col)])
          (cond
            [(char=? c #\\)
             (for ([k (in-range 3)])
               (vector-set! g (+ (* 3 row k) (* 3 col) k) 1))]
            [(char=? c #\/)
             (for ([k (in-range 3)])
               (vector-set! g (+ (* 3 row k) (* 3 (- 2 col)) k) 1))]))))
    (let ([res 0])
      (for ([i (in-range size)])
        (for ([j (in-range size)])
          (when (zero? (vector-ref g (+ (* i size) j)))
            (set! res (add1 res))
            (dfs g i j size))))
      res)))

(define (dfs g i j size)
  (when (and (>= i 0) (< i size) (>= j 0) (< j size) (zero? (vector-ref g (+ (* i size) j))))
    (vector-set! g (+ (* i size) j) 1)
    (dfs g (add1 i) j size)
    (dfs g (sub1 i) j size)
    (dfs g i (add1 j) size)
    (dfs g i (sub1 j) size)))