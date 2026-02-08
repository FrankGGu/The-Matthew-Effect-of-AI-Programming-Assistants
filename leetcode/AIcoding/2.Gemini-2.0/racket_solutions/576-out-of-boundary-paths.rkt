(define (find-paths m n max-move start-row start-column)
  (define memo (make-hash))
  (define (dfs row col moves)
    (cond
      [(< moves 0) 0]
      [(or (< row 0) (>= row m) (< col 0) (>= col n)) 1]
      [else
       (let ([key (list row col moves)])
         (if (hash-has-key? memo key)
             (hash-ref memo key)
             (let ([result
                    (modulo (+ (dfs (+ row 1) col (- moves 1))
                             (dfs (- row 1) col (- moves 1))
                             (dfs row (+ col 1) (- moves 1))
                             (dfs row (- col 1) (- moves 1)))
                            1000000007)])
               (hash-set! memo key result)
               result))))))
  (dfs start-row start-column max-move))