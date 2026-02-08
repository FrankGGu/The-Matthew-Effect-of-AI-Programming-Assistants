#lang racket

(require racket/set)
(require racket/list)

(define (count-lattice-points circles)
  (define min-x
    (foldl (lambda (circle current-min)
             (min current-min (- (car circle) (caddr circle))))
           +inf.0
           circles))
  (define max-x
    (foldl (lambda (circle current-max)
             (max current-max (+ (car circle) (caddr circle))))
           -inf.0
           circles))
  (define min-y
    (foldl (lambda (circle current-min)
             (min current-min (- (cadr circle) (caddr circle))))
           +inf.0
           circles))
  (define max-y
    (foldl (lambda (circle current-max)
             (max current-max (+ (cadr circle) (caddr circle))))
           -inf.0
           circles))

  (define unique-points (set))

  (for* ([x (in-range min-x (add1 max-x))]
         [y (in-range min-y (add1 max-y))])
    (define found-in-any-circle?
      (ormap (lambda (circle)
               (define xi (car circle))
               (define yi (cadr circle))
               (define ri (caddr circle))
               (define dx (- x xi))
               (define dy (- y yi))
               (<= (+ (* dx dx) (* dy dy)) (* ri ri)))
             circles))

    (when found-in-any-circle?
      (set! unique-points (set-add unique-points (list x y)))))

  (set-count unique-points))