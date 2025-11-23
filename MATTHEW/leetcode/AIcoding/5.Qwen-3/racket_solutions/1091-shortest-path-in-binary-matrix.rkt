#lang racket

(define (shortest-path-in-binary-matrix grid)
  (define n (length grid))
  (define directions '((0 1) (1 0) (0 -1) (-1 0) (1 1) (-1 -1) (-1 1) (1 -1)))
  (define (valid? x y)
    (and (<= 0 x (- n 1)) (<= 0 y (- n 1)) (= (list-ref (list-ref grid x) y) 0)))
  (define (bfs)
    (let loop ([queue (list (cons 0 0))] [dist 1] [visited (set 0 0)])
      (if (null? queue)
          -1
          (let* ([current (car queue)]
                 [x (car current)]
                 [y (cdr current)]
                 [next-queue (cdr queue)])
            (if (and (= x (- n 1)) (= y (- n 1)))
                dist
                (let ([new-queue (filter (lambda (p) (not (set-member? visited (cons (car p) (cdr p))))) 
                                        (append-map (lambda (d)
                                                      (let ([nx (+ x (car d))] [ny (+ y (cdr d))])
                                                        (if (valid? nx ny) (list (cons nx ny)) '())))
                                                    directions))])
                  (loop new-queue (+ dist 1) (set-union visited (set-map new-queue (lambda (p) (cons (car p) (cdr p))))))))))))
  (if (or (= (list-ref (list-ref grid 0) 0) 1) (= (list-ref (list-ref grid (- n 1)) (- n 1)) 1))
      -1
      (bfs)))