(define (snake-matrix matrix)
  (let* ((rows (length matrix))
         (cols (length (car matrix)))
         (visited (make-vector (* rows cols) #f))
         (path '())
         (directions '((0 1) (1 0) (0 -1) (-1 0))))

    (define (valid-move? row col)
      (and (>= row 0) (< row rows) (>= col 0) (< col cols)
           (not (vector-ref visited (+ (* row cols) col)))))

    (define (dfs row col)
      (begin
        (vector-set! visited (+ (* row cols) col) #t)
        (set! path (append path (list (list row col))))
        (cond
          [(empty? directions) #f]
          [else
           (let loop ((dirs directions))
             (cond
               [(empty? dirs) #f]
               [else
                (let* ((dir (car dirs))
                       (new-row (+ row (car dir)))
                       (new-col (+ col (cadr dir))))
                  (if (valid-move? new-row new-col)
                      (if (dfs new-row new-col)
                          #t
                          (begin
                            (vector-set! visited (+ (* new-row cols) new-col) #f)
                            (set! path (drop-right path 1))
                            (loop (cdr dirs))))
                      (loop (cdr dirs)))))]))]))

    (dfs 0 0)
    path))