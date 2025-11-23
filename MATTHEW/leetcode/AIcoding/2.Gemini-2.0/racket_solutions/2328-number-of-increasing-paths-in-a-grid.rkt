(define (count-paths grid)
  (let* ([m (vector-length grid)]
         [n (vector-length (vector-ref grid 0))]
         [dp (make-vector m (lambda (i) (make-vector n 0)))]
         [mod 1000000007]
         (define (dfs i j)
           (cond
             [(not (= (vector-ref (vector-ref dp i) j) 0)) (vector-ref (vector-ref dp i) j)]
             [else
              (let ([count 1])
                (when (and (> i 0) (> (vector-ref (vector-ref grid i) j) (vector-ref (vector-ref grid (- i 1)) j)))
                  (set! count (modulo (+ count (dfs (- i 1) j)) mod)))
                (when (and (< i (- m 1)) (> (vector-ref (vector-ref grid i) j) (vector-ref (vector-ref grid (+ i 1)) j)))
                  (set! count (modulo (+ count (dfs (+ i 1) j)) mod)))
                (when (and (> j 0) (> (vector-ref (vector-ref grid i) j) (vector-ref (vector-ref grid i) (- j 1))))
                  (set! count (modulo (+ count (dfs i (- j 1))) mod)))
                (when (and (< j (- n 1)) (> (vector-ref (vector-ref grid i) j) (vector-ref (vector-ref grid i) (+ j 1))))
                  (set! count (modulo (+ count (dfs i (+ j 1))) mod)))
                (vector-set! (vector-ref dp i) j count)
                count)]))
         [total-paths (for/sum ([i (in-range m)]
                                 [j (in-range n)])
                          (dfs i j))])
    (modulo total-paths mod)))