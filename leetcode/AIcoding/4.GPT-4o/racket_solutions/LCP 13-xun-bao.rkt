(define (treasure-hunt forest)
  (define (dfs x y)
    (if (or (< x 0) (>= x (length forest)) 
            (< y 0) (>= y (length (first forest))) 
            (not (= (list-ref (list-ref forest x) y) 1)))
        0
        (begin
          (set! (list-ref (list-ref forest x) y) 0)
          (+ 1 (dfs (+ x 1) y) (dfs (- x 1) y) 
                 (dfs x (+ y 1)) (dfs x (- y 1))))))
  (define max-treasure 0)
  (for ([i (in-range (length forest))])
    (for ([j (in-range (length (first forest)))])
      (when (= (list-ref (list-ref forest i) j) 1)
        (set! max-treasure (max max-treasure (dfs i j))))))
  max-treasure)

(define (maxTreasure forest)
  (treasure-hunt forest))