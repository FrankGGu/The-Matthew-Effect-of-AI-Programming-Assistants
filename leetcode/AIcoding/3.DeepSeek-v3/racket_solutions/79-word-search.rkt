(define (exist board word)
  (let ([rows (length board)]
        [cols (if (null? board) 0 (length (car board)))])
    (define (dfs i j k)
      (cond
        [(= k (string-length word)) #t]
        [(or (< i 0) (>= i rows) (< j 0) (>= j cols)
             (not (char=? (string-ref word k) (list-ref (list-ref board i) j))) #f]
        [else
         (let ([tmp (list-ref (list-ref board i) j)]
               [dirs '((0 1) (1 0) (0 -1) (-1 0))])
           (list-set! (list-ref board i) j #\null)
           (let ([res (ormap (lambda (dir)
                               (dfs (+ i (car dir)) (+ j (cadr dir)) (+ k 1)))
                             dirs)])
             (list-set! (list-ref board i) j tmp)
             res))]))
    (ormap (lambda (i)
             (ormap (lambda (j)
                      (dfs i j 0))
                    (range cols)))
           (range rows))))