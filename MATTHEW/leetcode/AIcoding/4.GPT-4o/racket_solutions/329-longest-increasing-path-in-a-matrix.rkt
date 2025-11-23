(define (longestIncreasingPath matrix)
  (define n (length matrix))
  (define m (if (> n 0) (length (car matrix)) 0))
  (define dp (make-vector n (make-vector m 0)))

  (define (dfs x y)
    (if (vector-ref (vector-ref dp x) y) 
        (vector-ref (vector-ref dp x) y)
        (begin
          (define max-path 1)
          (for ([dx (list -1 1 0 0)]
                [dy (list 0 0 -1 1)])
            (define nx (+ x dx))
            (define ny (+ y dy))
            (when (and (>= nx 0) (< nx n)
                       (>= ny 0) (< ny m)
                       (> (vector-ref (vector-ref matrix x) y)
                          (vector-ref (vector-ref matrix nx) ny))
              )
              (set! max-path (max max-path (+ 1 (dfs nx ny)))))
          (vector-set! (vector-ref dp x) y max-path)
          max-path)))

  (define max-length 0)
  (for ([i (in-range n)]
        [j (in-range m)])
    (set! max-length (max max-length (dfs i j))))
  max-length)