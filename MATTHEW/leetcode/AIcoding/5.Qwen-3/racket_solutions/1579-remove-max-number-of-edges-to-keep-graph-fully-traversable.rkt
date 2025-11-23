#lang racket

(define (remove-max-number-of-edges-to-keep-graph-fully-traversable n edges)
  (define (find parent x)
    (if (= parent x)
        x
        (let ([p (find parent (vector-ref parent x))])
          (vector-set! parent x p)
          p)))

  (define (union parent x y)
    (let ([xroot (find parent x)]
          [yroot (find parent y)])
      (if (= xroot yroot)
          #f
          (begin
            (vector-set! parent yroot xroot)
            #t))))

  (define (count-edges n edges)
    (define parent (make-vector n 0))
    (for ([i (in-range n)])
      (vector-set! parent i i))
    (define count 0)
    (for ([e edges])
      (let ([u (car e)]
            [v (cadr e)]
            [t (caddr e)])
        (when (= t 2)
          (if (union parent u v)
              (set! count (+ count 1))
              #f))))
    (define parent2 (make-vector n 0))
    (for ([i (in-range n)])
      (vector-set! parent2 i i))
    (for ([e edges])
      (let ([u (car e)]
            [v (cadr e)]
            [t (caddr e)])
        (when (= t 1)
          (if (union parent2 u v)
              (set! count (+ count 1))
              #f))))
    (- (length edges) count))

  (count-edges n edges))