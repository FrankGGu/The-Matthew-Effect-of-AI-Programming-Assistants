(define (exist board word)
  (define rows (length board))
  (define cols (length (car board)))

  (define (dfs row col index visited)
    (cond
      [(>= index (string-length word)) #t]
      [(or (< row 0) (>= row rows) (< col 0) (>= col cols)
           (hash-has-key? visited (cons row col))
           (not (char=? (string-ref word index) (list-ref (list-ref board row) col)))) #f]
      [else
       (let ([new-visited (hash-set visited (cons row col) #t)])
         (or (dfs (+ row 1) col (+ index 1) new-visited)
             (dfs (- row 1) col (+ index 1) new-visited)
             (dfs row (+ col 1) (+ index 1) new-visited)
             (dfs row (- col 1) (+ index 1) new-visited)))]))

  (define (find-start-points)
    (let loop ([r 0] [c 0] [acc '()])
      (cond
        [(>= r rows) acc]
        [(>= c cols) (loop (+ r 1) 0 acc)]
        [(char=? (string-ref word 0) (list-ref (list-ref board r) c)) (loop r (+ c 1) (cons (cons r c) acc))]
        [else (loop r (+ c 1) acc)])))

  (let ([start-points (find-start-points)])
    (if (null? start-points)
        #f
        (ormap (lambda (p) (dfs (car p) (cdr p) 0 (hash))) start-points))))