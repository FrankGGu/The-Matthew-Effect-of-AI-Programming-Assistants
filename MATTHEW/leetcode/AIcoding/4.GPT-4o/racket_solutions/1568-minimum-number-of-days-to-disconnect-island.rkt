#lang racket

(define (minDays grid)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid))
         (>= y 0) (< y (length (vector-ref grid 0)))))

  (define (dfs x y)
    (if (not (in-bounds? x y))
        0
        (if (or (= (vector-ref (vector-ref grid x) y) 0)
                (vector-ref (vector-ref grid x) y) = 2)
            0
            (begin
              (vector-set! (vector-ref grid x) y 2)
              (+ 1 (dfs (+ x 1) y)
                 (dfs (- x 1) y)
                 (dfs x (+ y 1))
                 (dfs x (- y 1)))))))

  (define (count-islands)
    (define count 0)
    (for* ([i (in-range (length grid))]
           [j (in-range (length (vector-ref grid 0)))])
      (if (= (vector-ref (vector-ref grid i) j) 1)
          (begin
            (dfs i j)
            (set! count (+ count 1)))))
    count)

  (if (= (count-islands) 0)
      0
      (if (= (count-islands) 1)
          1
          2)))