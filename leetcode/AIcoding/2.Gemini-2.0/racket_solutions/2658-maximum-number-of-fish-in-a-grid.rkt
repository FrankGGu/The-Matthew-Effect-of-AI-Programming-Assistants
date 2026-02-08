(define (max-fish grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (dfs row col visited)
    (cond
      [(or (< row 0) (>= row rows) (< col 0) (>= col cols) (memq (list row col) visited) (= (list-ref (list-ref grid row) col) 0))
       0]
      [else
       (define current-fish (list-ref (list-ref grid row) col))
       (define new-visited (cons (list row col) visited))
       (+ current-fish
          (dfs (add1 row) col new-visited)
          (dfs (sub1 row) col new-visited)
          (dfs row (add1 col) new-visited)
          (dfs row (sub1 col) new-visited))]))

  (define (solve)
    (let loop ([row 0] [col 0] [max-so-far 0] [visited '()])
      (cond
        [(>= row rows) max-so-far]
        [(>= col cols) (loop (add1 row) 0 max-so-far visited)]
        [else
         (if (or (memq (list row col) visited) (= (list-ref (list-ref grid row) col) 0))
             (loop row (add1 col) max-so-far visited)
             (let ([current-fish (dfs row col visited)])
               (loop row (add1 col) (max max-so-far current-fish) visited)))])))

  (solve))