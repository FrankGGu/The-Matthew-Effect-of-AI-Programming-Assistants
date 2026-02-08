(define (hitBricks grid hits)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid)) (>= y 0) (< y (length (vector-ref grid 0)))))

  (define (dfs x y)
    (if (not (in-bounds? x y))
        0
        (let ([cell (vector-ref (vector-ref grid x) y)])
          (if (or (not (= cell 1)) (vector-ref visited x y))
              0
              (begin
                (set! (vector-ref visited x y) #t)
                (for-each (lambda (k)
                            (dfs (+ x (vector-ref directions k 0)) 
                                 (+ y (vector-ref directions k 1))))
                          (range 4))
                1))))

  (define (count-stable x y)
    (if (not (in-bounds? x y))
        0
        (if (not (= (vector-ref (vector-ref grid x) y) 1))
            0
            (begin
              (set! (vector-ref visited x y) #t)
              (for-each (lambda (k)
                          (count-stable (+ x (vector-ref directions k 0)) 
                                         (+ y (vector-ref directions k 1))))
                        (range 4))
              1))))

  (define (connect-bricks)
    (set! visited (make-vector (length grid) (make-vector (length (vector-ref grid 0)) #f)))
    (for-each (lambda (y) (count-stable 0 y)) (range (length (vector-ref grid 0))))

  (define (process-hits)
    (for-each (lambda (hit)
                (define x (car hit))
                (define y (cadr hit))
                (when (in-bounds? x y)
                  (set! (vector-ref (vector-ref grid x) y) 1)))
              hits))
    (connect-bricks)

  (define (result)
    (define res (make-vector (length hits) 0))
    (for-each (lambda (i hit)
                (define x (car hit))
                (define y (cadr hit))
                (when (in-bounds? x y)
                  (set! (vector-ref (vector-ref grid x) y) 1)
                  (set! visited (make-vector (length grid) (make-vector (length (vector-ref grid 0)) #f)))
                  (when (dfs 0 y)
                    (set! (vector-ref res i) (count-stable x y)))))
              (reverse (range (length hits))))
    (vector->list (reverse res)))

  (process-hits)
  (result))

(define (vector->list v)
  (for/list ([i (in-range (vector-length v))])
    (vector-ref v i)))

(define (range n)
  (if (= n 0)
      '()
      (cons (- n 1) (range (- n 1)))))

(define directions (vector (vector 1 0) (vector -1 0) (vector 0 1) (vector 0 -1)))

(hitBricks grid hits)