(define (exist board word)
  (define rows (length board))
  (define cols (length (car board)))
  (define word-len (string-length word))

  (define (dfs row col index visited)
    (cond
      [(>= index word-len) #t]
      [(or (< row 0) (>= row rows)
           (< col 0) (>= col cols)
           (hash-has-key? visited (cons row col))
           (not (char=? (string-ref word index) (list-ref (list-ref board row) col)))) #f]
      [else
       (let ([new-visited (hash-set visited (cons row col) #t)])
         (or (dfs (+ row 1) col (+ index 1) new-visited)
             (dfs (- row 1) col (+ index 1) new-visited)
             (dfs row (+ col 1) (+ index 1) new-visited)
             (dfs row (- col 1) (+ index 1) new-visited)))]))

  (define (find-start)
    (for*/or ([row (in-range rows)]
              [col (in-range cols)])
      (if (char=? (string-ref word 0) (list-ref (list-ref board row) col))
          (dfs row col 1 (hash (cons row col) #t))
          #f)))

  (find-start))