(define (num-darts-in-circle radius darts)
  (define (inside-circle x y)
    (<= (+ (* x x) (* y y)) (* radius radius)))
  (define (count-darts darts)
    (length (filter (lambda (dart) (inside-circle (car dart) (cadr dart))) darts)))
  (count-darts darts))

(define (max-darts-inside-circle radius darts)
  (num-darts-in-circle radius darts))

(max-darts-inside-circle 1 '((1 0) (0 1) (0 0) (1 1) (2 2)))