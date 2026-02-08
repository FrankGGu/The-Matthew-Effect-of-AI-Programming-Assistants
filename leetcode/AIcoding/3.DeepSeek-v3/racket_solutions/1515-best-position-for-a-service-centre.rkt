#lang racket

(define (get-min-dist-sum positions)
  (define (dist x y)
    (for/sum ([pos (in-list positions)])
      (match-define (list xi yi) pos)
      (sqrt (+ (sqr (- xi x)) (sqr (- yi y)))))

  (define (gradient x y)
    (define-values (dx dy)
      (for/fold ([dx 0.0] [dy 0.0]) ([pos (in-list positions)])
        (match-define (list xi yi) pos)
        (define d (sqrt (+ (sqr (- xi x)) (sqr (- yi y)))))
        (if (zero? d)
            (values dx dy)
            (values (+ dx (/ (- x xi) d))
                    (+ dy (/ (- y yi) d))))))
    (values dx dy))

  (define (step x y alpha)
    (define-values (dx dy) (gradient x y))
    (values (- x (* alpha dx))
            (- y (* alpha dy))))

  (define (find-min)
    (let loop ([x 50.0] [y 50.0] [alpha 1.0] [prev-dist +inf.0] [count 0])
      (define current-dist (dist x y))
      (if (or (< (abs (- prev-dist current-dist)) 1e-7) (> count 10000))
          current-dist
          (let-values ([(new-x new-y) (step x y alpha)])
            (if (< (dist new-x new-y) current-dist)
                (loop new-x new-y alpha current-dist (add1 count))
                (loop x y (/ alpha 2.0) current-dist (add1 count)))))))

  (find-min))