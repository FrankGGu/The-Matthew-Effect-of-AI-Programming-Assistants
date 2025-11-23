#lang racket

(define (find-parent parent x)
  (if (= (vector-ref parent x) x)
      x
      (let ([p (find-parent parent (vector-ref parent x))])
        (vector-set! parent x p)
        p)))

(define (union parent rank x y)
  (let ([x-root (find-parent parent x)]
        [y-root (find-parent parent y)])
    (cond
      [(= x-root y-root) #f]
      [else
       (if (< (vector-ref rank x-root) (vector-ref rank y-root))
           (vector-set! parent x-root y-root)
           (begin
             (vector-set! parent y-root x-root)
             (when (= (vector-ref rank x-root) (vector-ref rank y-root))
               (vector-set! rank x-root (+ (vector-ref rank x-root) 1)))))
       #t)])))

(define (minimize-max-weight n edges)
  (let* ([parent (build-vector n (lambda (i) i))]
         [rank (make-vector n 0)]
         [sorted-edges (sort edges (lambda (a b) (< (third a) (third b))))]
         [result 0]
         [count 0])
    (for ([edge (in-list sorted-edges)])
      (when (union parent rank (first edge) (second edge))
        (set! result (max result (third edge)))
        (set! count (+ count 1))
        (when (= count (- n 1)) (break)))
    result))