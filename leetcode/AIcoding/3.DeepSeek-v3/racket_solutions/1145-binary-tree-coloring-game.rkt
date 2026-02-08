#lang racket

(define (btree-game-winning-move root n x)
  (define left-size 0)
  (define right-size 0)

  (define (count-nodes node)
    (if (null? node)
        0
        (let ([l (count-nodes (vector-ref node 1))]
              [r (count-nodes (vector-ref node 2))])
          (cond
            [(= (vector-ref node 0) x)
             (set! left-size l)
             (set! right-size r)
             0]
            [else (+ l r 1)])))

  (count-nodes root)
  (let ([parent-size (- n 1 left-size right-size)])
    (or (> parent-size (+ left-size right-size 1))
        (> left-size (+ parent-size right-size 1))
        (> right-size (+ parent-size left-size 1)))))