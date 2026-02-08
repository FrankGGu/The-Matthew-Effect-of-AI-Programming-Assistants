(define (update-board board click)
  (let* ([m (length board)]
         [n (if (zero? m) 0 (string-length (car board)))]
         [x (car click)]
         [y (cadr click)]
         [dirs '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1))])
    (cond
      [(char=? (string-ref (list-ref board x) y) #\M)
       (list-set board x (string-replace (list-ref board x) y #\X))]
      [else
       (let ([count (for/sum ([dir dirs])
                      (let ([nx (+ x (car dir))]
                            [ny (+ y (cadr dir))])
                        (if (and (>= nx 0) (< nx m) (>= ny 0) (< ny n)
                            (char=? (string-ref (list-ref board nx) ny) #\M))
                            1
                            0)))])
         (if (positive? count)
             (list-set board x (string-replace (list-ref board x) y (integer->char (+ (char->integer #\0) count))))
             (let ([new-board (list-set board x (string-replace (list-ref board x) y #\B))])
               (for/fold ([board new-board]) ([dir dirs])
                 (let ([nx (+ x (car dir))]
                       [ny (+ y (cadr dir))])
                   (if (and (>= nx 0) (< nx m) (>= ny 0) (< ny n)
                            (char=? (string-ref (list-ref board nx) ny) #\E))
                       (update-board board (list nx ny))
                       board)))))])))