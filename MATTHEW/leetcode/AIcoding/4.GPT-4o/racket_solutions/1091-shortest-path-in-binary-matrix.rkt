(define (shortest-path-binary-matrix grid)
  (define n (length grid))
  (define directions '((0 1) (1 0) (0 -1) (-1 0) (1 1) (1 -1) (-1 1) (-1 -1)))
  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y n) (= 0 (vector-ref (vector-ref grid x) y))))
  (define (bfs)
    (let ([queue (list (list 0 0 1))] )
      (define visited (make-vector n (lambda () (make-vector n #f))))
      (vector-set! visited 0 (make-vector n #t))
      (let loop ()
        (if (null? queue)
            -1
            (let* ([current (car queue)]
                   [x (car current)]
                   [y (cadr current)]
                   [dist (caddr current)])
              (set! queue (cdr queue))
              (if (and (= x (- n 1)) (= y (- n 1)))
                  dist
                  (for-each (lambda (d)
                              (let* ([nx (+ x (car d))]
                                     [ny (+ y (cadr d))])
                                (when (valid? nx ny)
                                  (vector-set! (vector-ref visited nx) ny #t)
                                  (set! queue (append queue (list (list nx ny (+ dist 1))))))))
                            directions)
                  (loop)))))))
  (if (= 1 (vector-ref (vector-ref grid 0) 0))
      -1
      (bfs)))