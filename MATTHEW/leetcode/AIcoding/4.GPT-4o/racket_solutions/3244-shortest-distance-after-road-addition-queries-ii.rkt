#lang racket

(struct edge (u v))

(define (find parent x)
  (if (not (= (vector-ref parent x) x))
      (find parent (vector-ref parent x))
      x))

(define (union parent rank x y)
  (define rootX (find parent x))
  (define rootY (find parent y))
  (if (not (= rootX rootY))
      (begin
        (if (> (vector-ref rank rootX) (vector-ref rank rootY))
            (vector-set! parent rootY rootX)
            (begin
              (vector-set! parent rootX rootY)
              (if (= (vector-ref rank rootX) (vector-ref rank rootY))
                  (vector-set! rank rootY (+ (vector-ref rank rootY) 1))))))))

(define (connected parent x y)
  (= (find parent x) (find parent y)))

(define (shortest-distance-queries edges queries)
  (define n (add1 (apply max (map (λ (e) (max (edge-u e) (edge-v e))) edges))))
  (define parent (vector (iota n)))
  (define rank (vector (make-list n 0)))

  (for ([e edges])
    (union parent rank (edge-u e) (edge-v e)))

  (define results '())
  (for ([q queries])
    (define u (car q))
    (define v (cadr q))
    (if (connected parent u v)
        (set! results (cons -1 results))
        (begin
          (union parent rank u v)
          (set! results (cons 1 results)))))
  (reverse results))

(define (main)
  (define edges (list (edge 0 1) (edge 1 2)))
  (define queries (list (list 0 2) (list 1 2)))
  (shortest-distance-queries edges queries))

(main)