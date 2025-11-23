(define (findBall grid)
  (define (move col)
    (if (or (< col 0) (>= col (length (vector-ref grid 0))))
        -1
        (let* ((row 0)
               (next-col (if (eq? (vector-ref (vector-ref grid row) col) 1)
                              (+ col 1)
                              (- col 1))))
          (if (or (and (= (vector-ref (vector-ref grid row) col) 1)
                       (= (vector-ref (vector-ref grid row) next-col) -1))
                  (and (= (vector-ref (vector-ref grid row) col) -1)
                       (= (vector-ref (vector-ref grid row) next-col) 1)))
              -1
              (if (= row (sub1 (length grid)))
                  next-col
                  (move next-col (add1 row))))))))

  (define (dropBall col)
    (let loop ((row 0) (c col))
      (if (= row (length grid))
          c
          (let* ((next-col (if (eq? (vector-ref (vector-ref grid row) c) 1)
                               (+ c 1)
                               (- c 1))))
            (if (or (and (= (vector-ref (vector-ref grid row) c) 1)
                         (= (vector-ref (vector-ref grid row) next-col) -1))
                    (and (= (vector-ref (vector-ref grid row) c) -1)
                         (= (vector-ref (vector-ref grid row) next-col) 1)))
                -1
                (loop (add1 row) next-col))))))

  (define (simulate)
    (for/list ((col (in-range (length (vector-ref grid 0)))))
      (dropBall col)))

  (let loop ((k 0))
    (if (= k 0)
        (simulate)
        (loop (sub1 k)))))

(findBall grid)