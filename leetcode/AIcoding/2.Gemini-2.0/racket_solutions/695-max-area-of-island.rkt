(define (max-area-of-island grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (dfs i j)
    (cond
      [(or (< i 0) (>= i rows) (< j 0) (>= j cols) (= (list-ref (list-ref grid i) j) 0)) 0]
      [else
       (set! (list-ref (list-ref grid i) j) 0)
       (+ 1
          (dfs (+ i 1) j)
          (dfs (- i 1) j)
          (dfs i (+ j 1))
          (dfs i (- j 1)))]))

  (let loop ([i 0] [max-area 0])
    (cond
      [(>= i rows) max-area]
      [else
       (let loop2 ([j 0] [max-area2 max-area])
         (cond
           [(>= j cols) (loop (+ i 1) max-area2)]
           [else
            (if (= (list-ref (list-ref grid i) j) 1)
                (loop2 (+ j 1) (max max-area2 (dfs i j)))
                (loop2 (+ j 1) max-area2))]))])))