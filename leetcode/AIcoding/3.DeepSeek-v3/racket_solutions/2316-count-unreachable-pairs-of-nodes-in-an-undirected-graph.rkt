#lang racket

(define (count-pairs n edges)
  (define parent (make-vector n))
  (define size (make-vector n 1))

  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (begin
          (vector-set! parent u (find (vector-ref parent u)))
          (vector-ref parent u))))

  (define (union u v)
    (define root-u (find u))
    (define root-v (find v))
    (when (not (= root-u root-v))
      (if (< (vector-ref size root-u) (vector-ref size root-v))
          (begin
            (vector-set! parent root-u root-v)
            (vector-set! size root-v (+ (vector-ref size root-v) (vector-ref size root-u))))
          (begin
            (vector-set! parent root-v root-u)
            (vector-set! size root-u (+ (vector-ref size root-u) (vector-ref size root-v)))))))

  (for ([edge edges])
    (union (car edge) (cadr edge)))

  (define component-sizes (make-hash))
  (for ([i (in-range n)])
    (define root (find i))
    (hash-update! component-sizes root (lambda (x) (+ x 1)) 0))

  (define total-pairs (/ (* n (- n 1)) 2))
  (define connected-pairs 0)

  (for ([(root cnt) (in-hash component-sizes)])
    (set! connected-pairs (+ connected-pairs (/ (* cnt (- cnt 1)) 2))))

  (- total-pairs connected-pairs))