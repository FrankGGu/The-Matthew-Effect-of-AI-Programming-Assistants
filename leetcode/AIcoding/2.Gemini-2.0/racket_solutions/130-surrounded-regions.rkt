(define (solve board)
  (define rows (length board))
  (define cols (if (null? board) 0 (length (car board))))

  (define (is-valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c)
    (when (and (is-valid? r c) (equal? (list-ref (list-ref board r) c) 'O))
      (set! board (list-set (list-set board r (list-set (list-ref board r) c 'T')) r (list-set (list-ref board r) c 'T')))
      (dfs (+ r 1) c)
      (dfs (- r 1) c)
      (dfs r (+ c 1))
      (dfs r (- c 1))))

  (for ([r (in-range rows)])
    (begin
      (dfs r 0)
      (dfs r (- cols 1))))

  (for ([c (in-range cols)])
    (begin
      (dfs 0 c)
      (dfs (- rows 1) c)))

  (for* ([r (in-range rows)]
         [c (in-range cols)])
    (cond
      [(equal? (list-ref (list-ref board r) c) 'O)
       (set! board (list-set (list-set board r (list-set (list-ref board r) c 'X')) r (list-set (list-ref board r) c 'X')))]
      [(equal? (list-ref (list-ref board r) c) 'T)
       (set! board (list-set (list-set board r (list-set (list-ref board r) c 'O')) r (list-set (list-ref board r) c 'O')))]))
  board)