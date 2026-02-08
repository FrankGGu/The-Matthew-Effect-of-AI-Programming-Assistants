(define (count-sub-islands grid1 grid2)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid1)) (>= y 0) (< y (length (vector-ref grid1 0)))))

  (define (dfs x y)
    (if (not (in-bounds? x y))
        #f
        (begin
          (if (= (vector-ref (vector-ref grid2 x) y) 0)
              #t
              (begin
                (vector-set! (vector-ref grid2 x) y 0)
                (define current (vector-ref (vector-ref grid1 x) y))
                (define left (dfs (+ x 0) (- y 1)))
                (define right (dfs (+ x 0) (+ y 1)))
                (define up (dfs (- x 1) (+ y 0)))
                (define down (dfs (+ x 1) (+ y 0)))
                (and current left right up down))))))

  (define count 0)
  (for ((i (in-range (length grid1)))
        (j (in-range (length (vector-ref grid1 0)))))
    (when (and (= (vector-ref (vector-ref grid2 i) j) 1)
               (dfs i j))
      (set! count (+ count 1))))
  count)

(define grid1 #([[1,1,0],[0,1,1],[0,0,0]])
(define grid2 #([[1,1,0],[0,1,1],[0,0,0]])
(count-sub-islands grid1 grid2)