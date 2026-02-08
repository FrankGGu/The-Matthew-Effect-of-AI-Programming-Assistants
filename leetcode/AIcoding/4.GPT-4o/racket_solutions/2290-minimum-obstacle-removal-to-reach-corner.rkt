(define (min-obstacles grid)
  (define n (length grid))
  (define m (length (car grid)))
  (define directions '((1 0) (-1 0) (0 1) (0 -1)))

  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y m)))

  (define (bfs)
    (define queue (list (list 0 0 0))) ;; (obstacle-count x y)
    (define visited (make-vector (* n m) #f))
    (vector-set! visited 0 #t)

    (let loop ()
      (if (null? queue)
          -1
          (let* ((current (car queue))
                 (obstacles (car current))
                 (x (cadr current))
                 (y (caddr current)))
            (set! queue (cdr queue))
            (if (and (= x (- n 1)) (= y (- m 1)))
                obstacles
                (for-each (lambda (dir)
                            (let* ((new-x (+ x (car dir)))
                                   (new-y (+ y (cadr dir)))
                                   (new-obstacles (+ obstacles (if (= (vector-ref (vector-ref grid new-x) new-y) 1) 1 0))))
                              (when (and (valid? new-x new-y) (not (vector-ref visited (+ (* new-x m) new-y))))
                                (vector-set! visited (+ (* new-x m) new-y) #t)
                                (set! queue (append queue (list (list new-obstacles new-x new-y)))))))
                          directions))
            (loop)))))

  (bfs))