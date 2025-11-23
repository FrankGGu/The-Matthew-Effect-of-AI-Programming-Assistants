(define (max-area-of-island grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (dfs r c)
    (cond
      [(or (< r 0) (>= r rows) (< c 0) (>= c cols) (= (list-ref (list-ref grid r) c) 0)) 0]
      [else
       (set! (list-ref (list-ref grid r) c) 0)
       (+ 1
          (dfs (+ r 1) c)
          (dfs (- r 1) c)
          (dfs r (+ c 1))
          (dfs r (- c 1)))]))

  (let loop ([r 0] [c 0] [max-area 0])
    (cond
      [(>= r rows) max-area]
      [(>= c cols) (loop (+ r 1) 0 max-area)]
      [else
       (loop r (+ c 1) (max max-area (dfs r c)))])))