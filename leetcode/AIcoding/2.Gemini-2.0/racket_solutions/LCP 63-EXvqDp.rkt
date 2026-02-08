(define (solve board)
  (define rows (length board))
  (define cols (length (first board)))
  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c dir visited)
    (cond
      [(not (valid? r c)) #f]
      [(member (list r c dir) visited) #f]
      [(= (list r c dir) '(0 0 1)) #t] ; Start at (0,0) heading right
      [(= (list r c dir) '(0 0 3)) #t] ; Start at (0,0) heading down
      [(= (list r c dir) '(rows-1 cols-1 0)) #t] ; End at (rows-1, cols-1) heading up
      [(= (list r c dir) '(rows-1 cols-1 2)) #t] ; End at (rows-1, cols-1) heading left
      [else
       (let* ([new-visited (cons (list r c dir) visited)]
              [cell (list-ref (list-ref board r) c)])
         (cond
           [(= cell 1) ; / mirror
            (cond
              [(= dir 0) (dfs (sub1 r) (add1 c) 3 new-visited)]  ;up -> right
              [(= dir 1) (dfs (add1 r) (sub1 c) 2 new-visited)]  ;right -> down
              [(= dir 2) (dfs (add1 r) (sub1 c) 2 new-visited)]  ;down -> left
              [(= dir 3) (dfs (sub1 r) (add1 c) 3 new-visited)]) ;left -> up
            ]
           [(= cell -1) ; \ mirror
            (cond
              [(= dir 0) (dfs (add1 r) (sub1 c) 1 new-visited)] ;up -> left
              [(= dir 1) (dfs (sub1 r) (add1 c) 0 new-visited)] ;right -> up
              [(= dir 2) (dfs (sub1 r) (add1 c) 0 new-visited)] ;down -> right
              [(= dir 3) (dfs (add1 r) (sub1 c) 1 new-visited)]) ;left -> down
            ]
           [else #f]))])]))

  (or (dfs 0 0 1 '()) (dfs 0 0 3 '())))

(define (marble-game board)
  (if (null? board)
      #f
      (solve board)))