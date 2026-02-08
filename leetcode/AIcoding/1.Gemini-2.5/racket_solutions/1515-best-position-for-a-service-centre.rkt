#lang racket

(define (get-dist-sum x y points)
  (define (euclidean-distance p1x p1y p2x p2y)
    (sqrt (+ (sq (- p1x p2x)) (sq (- p1y p2y)))))
  (apply + (map (lambda (p) (euclidean-distance x y (first p) (second p))) points)))

(define (get-best-position-for-service-centre points)
  (define n (length points))

  (define initial-x
    (/ (apply + (map first points)) (real->flonum n)))
  (define initial-y
    (/ (apply + (map second points)) (real->flonum n)))

  (define current-x initial-x)
  (define current-y initial-y)
  (define step 100.0)
  (define epsilon 1e-7)

  (let loop ()
    (when (> step epsilon)
      (define best-x-in-iter current-x)
      (define best-y-in-iter current-y)
      (define min-sum-in-iter (get-dist-sum current-x current-y points))

      (define improved-in-this-step-size-round? #f)

      (define directions
        (list (list 0.0 1.0) (list 0.0 -1.0)
              (list 1.0 0.0) (list -1.0 0.0)
              (list 1.0 1.0) (list 1.0 -1.0)
              (list -1.0 1.0) (list -1.0 -1.0)))

      (for-each (lambda (dir-vec)
                  (define dx (first dir-vec))
                  (define dy (second dir-vec))
                  (define next-x (+ current-x (* dx step)))
                  (define next-y (+ current-y (* dy step)))
                  (define next-sum (get-dist-sum next-x next-y points))
                  (when (< next-sum min-sum-in-iter)
                    (set! min-sum-in-iter next-sum)
                    (set! best-x-in-iter next-x)
                    (set! best-y-in-iter next-y)
                    (set! improved-in-this-step-size-round? #t)))
                directions)

      (if improved-in-this-step-size-round?
          (begin
            (set! current-x best-x-in-iter)
            (set! current-y best-y-in-iter)
            (loop))
          (begin
            (set! step (/ step 2.0))
            (loop)))))
  (list current-x current-y))