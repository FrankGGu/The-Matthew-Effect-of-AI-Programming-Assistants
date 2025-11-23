(define (largestIsland grid)
  (define n (length grid))
  (define area (make-vector (+ 1 (* n n)) 0))
  (define id 2)

  (define (dfs x y)
    (if (or (< x 0) (>= x n) (< y 0) (>= y n) (not (= (vector-ref (vector-ref grid x) y) 1)))
        0
        (begin
          (vector-set! (vector-ref grid x) y id)
          (+ 1 (dfs (+ x 1) y) (dfs (- x 1) y) (dfs x (+ y 1)) (dfs x (- y 1))))))

  (for ([i (in-range n)] [j (in-range n)])
    (when (= (vector-ref (vector-ref grid i) j) 1)
      (vector-set! area id (dfs i j))
      (set! id (+ id 1))))

  (define max-area (apply max (vector->list (vector-filter (lambda (x) (> x 0)) area))))

  (for ([i (in-range n)] [j (in-range n)])
    (when (= (vector-ref (vector-ref grid i) j) 0)
      (define seen (make-set))
      (for ([di (list 1 -1)] [dj (list 0 0)] [dj2 (list 0 0)] [dj3 (list 0 1 -1)])
        (let ([ni (+ i di)] [nj (+ j dj)])
          (when (and (>= ni 0) (< ni n) (>= nj 0) (< nj n))
            (let ([cur-id (vector-ref (vector-ref grid ni) nj)])
              (when (> cur-id 1)
                (set! seen (set-add seen cur-id))))))
        )
      (define current-area (apply + (map (lambda (x) (vector-ref area x)) (set->list seen))))
      (set! max-area (max max-area (+ current-area 1)))))

  max-area)