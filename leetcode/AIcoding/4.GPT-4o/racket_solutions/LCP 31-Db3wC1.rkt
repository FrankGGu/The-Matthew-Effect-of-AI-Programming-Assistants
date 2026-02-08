#lang racket

(define (can-reach-destination maze start end)
  (define n (length maze))
  (define m (length (first maze)))
  (define directions '((1 0) (0 1) (-1 0) (0 -1)))

  (define (in-bounds? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y m)))

  (define (valid-move? x y)
    (and (in-bounds? x y) (= (list-ref (list-ref maze x) y) 0)))

  (define (dfs x y visited)
    (if (equal? (list x y) end)
        #t
        (begin
          (set! visited (cons (list x y) visited))
          (for/or ([dir directions])
            (let* ([new-x (+ x (first dir))]
                   [new-y (+ y (second dir))])
              (and (valid-move? new-x new-y)
                   (not (member (list new-x new-y) visited))
                   (dfs new-x new-y visited)))))))

  (dfs (first start) (second start) '()))

(define (isPath maze start end)
  (can-reach-destination maze start end))