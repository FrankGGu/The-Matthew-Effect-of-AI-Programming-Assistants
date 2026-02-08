(define (uniquePathsIII grid)
  (define (dfs x y remain)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (vector-ref grid x)) (length (vector-ref grid 0))) (not (= (vector-ref (vector-ref grid x) y) 0)))
        0
        (if (= (vector-ref (vector-ref grid x) y) 2)
            (if (= remain 0) 1 0)
            (begin
              (define temp (vector-ref (vector-ref grid x) y))
              (vector-set! (vector-ref grid x) y -1)
              (define paths (+ (dfs (+ x 1) y (- remain 1))
                               (dfs (- x 1) y (- remain 1))
                               (dfs x (+ y 1) (- remain 1))
                               (dfs x (- y 1) (- remain 1))))
              (vector-set! (vector-ref grid x) y temp)
              paths))))

  (define start (for/fold ([coords '()]) ([i (in-range (length grid))] [j (in-range (length (vector-ref grid i)))])
                  (if (= (vector-ref (vector-ref grid i) j) 1)
                      (cons (list i j) coords)
                      coords)))

  (define end (for/fold ([coords '()]) ([i (in-range (length grid))] [j (in-range (length (vector-ref grid i)))])
                  (if (= (vector-ref (vector-ref grid i) j) 2)
                      (cons (list i j) coords)
                      coords)))

  (define remain (for/sum ([i (in-range (length grid))] [j (in-range (length (vector-ref grid i)))])
                    (if (= (vector-ref (vector-ref grid i) j) 0) 1 0)))

  (dfs (car start) (cadr start) (+ remain 1)))