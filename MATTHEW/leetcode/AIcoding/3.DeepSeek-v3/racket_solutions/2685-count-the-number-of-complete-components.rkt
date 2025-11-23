#lang racket

(define (count-complete-components n edges)
  (define parent (make-vector n 0))
  (define size (make-vector n 1))
  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))
  (define (union u v)
    (let ([u-root (find u)]
          [v-root (find v)])
      (when (not (= u-root v-root))
        (if (< (vector-ref size u-root) (vector-ref size v-root))
            (begin
              (vector-set! parent u-root v-root)
              (vector-set! size v-root (+ (vector-ref size v-root) (vector-ref size u-root))))
            (begin
              (vector-set! parent v-root u-root)
              (vector-set! size u-root (+ (vector-ref size u-root) (vector-ref size v-root))))))))

  (for ([i (in-range n)])
    (vector-set! parent i i))

  (for ([edge edges])
    (union (first edge) (second edge)))

  (define components (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (hash-update! components root (lambda (lst) (cons i lst)) (lambda () '()))))

  (define component-edges (make-hash))
  (for ([edge edges])
    (let ([root (find (first edge))])
      (hash-update! component-edges root (lambda (cnt) (+ cnt 1)) (lambda () 0))))

  (define complete-count 0)
  (for ([(root nodes) (in-hash components)])
    (let* ([m (length nodes)]
           [required-edges (/ (* m (- m 1)) 2)]
           [actual-edges (hash-ref component-edges root 0)])
      (when (= actual-edges required-edges)
        (set! complete-count (+ complete-count 1)))))

  complete-count)