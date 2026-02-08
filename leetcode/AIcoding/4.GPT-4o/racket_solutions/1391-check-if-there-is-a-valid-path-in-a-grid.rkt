#lang racket

(define (hasValidPath grid)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid)) (>= y 0) (< y (length (vector-ref grid x)))))

  (define (can-move? dir)
    (or (and (= dir 1) (memq (vector-ref (vector-ref grid x) y) '(1 4 6)))
        (and (= dir 2) (memq (vector-ref (vector-ref grid x) y) '(1 3 5)))
        (and (= dir 3) (memq (vector-ref (vector-ref grid x) y) '(2 3 6)))
        (and (= dir 4) (memq (vector-ref (vector-ref grid x) y) '(2 4 5)))))

  (define (dfs x y)
    (if (and (= x (- (length grid) 1)) (= y (- (length (vector-ref grid 0)) 1)))
        #t
        (begin
          (set! visited (set-add visited (list x y)))
          (for/or ([dir (in-list '(1 2 3 4))])
            (let ([nx (+ x (if (= dir 1) 0 (if (= dir 2) 0 (if (= dir 3) -1 1))))])
                  [ny (+ y (if (= dir 1) -1 (if (= dir 2) 1 (if (= dir 3) 0 0))))])
              (and (in-bounds? nx ny)
                   (not (set-member? visited (list nx ny)))
                   (can-move? dir)
                   (dfs nx ny)))))))

  (define visited (set))
  (dfs 0 0))