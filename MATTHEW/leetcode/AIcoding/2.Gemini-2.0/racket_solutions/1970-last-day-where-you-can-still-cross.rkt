(define (latest-day-to-cross row col cells)
  (define (can-cross? day)
    (define grid (make-vector row (make-vector col #f)))
    (for ([i (in-range day)])
      (let ([cell (list-ref cells i)])
        (vector-set! (vector-ref grid (- (car cell) 1)) (- (cdr cell) 1) #t)))

    (define visited (make-vector row (make-vector col #f)))

    (define (dfs r c)
      (cond
        [(or (< r 0) (>= r row) (< c 0) (>= c col) (vector-ref (vector-ref grid r) c) (vector-ref (vector-ref visited r) c))
         #f]
        [(= r (- row 1)) #t]
        [else
         (vector-set! (vector-ref visited r) c #t)
         (or (dfs (+ r 1) c)
             (dfs (- r 1) c)
             (dfs r (+ c 1))
             (dfs r (- c 1)))]))

    (for/or ([c (in-range col)])
      (and (not (vector-ref (vector-ref grid 0) c))
           (dfs 0 c))))

  (let loop ([left 1] [right (length cells)])
    (cond
      [(> left right) (- left 1)]
      [else
       (let ([mid (quotient (+ left right) 2)])
         (if (can-cross? mid)
             (loop (+ mid 1) right)
             (loop left (- mid 1))))])))