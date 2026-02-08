(define (exist board word)
  (define (dfs x y index)
    (if (or (< x 0) (>= x (length board)) 
            (< y 0) (>= y (length (vector-ref board 0))) 
            (not (= (vector-ref (vector-ref board x) y) (string-ref word index))) 
            (>= index (string-length word)))
        #f
        (begin
          (vector-set! (vector-ref board x) y #\0)
          (define found (or (dfs (+ x 1) y (+ index 1))
                            (dfs (- x 1) y (+ index 1))
                            (dfs x (+ y 1) (+ index 1))
                            (dfs x (- y 1) (+ index 1))))
          (vector-set! (vector-ref board x) y (string-ref word index))
          found)))
  (for/fold ([found #f]) ([i (in-range (length board))])
    (if found
        found
        (for/fold ([found #f]) ([j (in-range (length (vector-ref board i)))])
          (if found
              found
              (if (= (vector-ref (vector-ref board i) j) (string-ref word 0))
                  (dfs i j 0)
                  found))))))