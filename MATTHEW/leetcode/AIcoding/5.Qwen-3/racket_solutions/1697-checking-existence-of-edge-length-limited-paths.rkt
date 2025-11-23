#lang racket

(define (distance-limited-paths n edges)
  (define/contract (find parent x)
    (-> (vector/c exact-integer?) exact-integer? exact-integer?)
    (if (= (vector-ref parent x) x)
        x
        (let ([p (find parent (vector-ref parent x))])
          (vector-set! parent x p)
          p)))

  (define/contract (union parent rank x y)
    (-> (vector/c exact-integer?) (vector/c exact-integer?) exact-integer? exact-integer? void?)
    (let ([xroot (find parent x)]
          [yroot (find parent y)])
      (when (not (= xroot yroot))
        (when (< (vector-ref rank xroot) (vector-ref rank yroot))
          (vector-set! parent xroot yroot))
        (when (>= (vector-ref rank xroot) (vector-ref rank yroot))
          (vector-set! parent yroot xroot)
          (when (= (vector-ref rank xroot) (vector-ref rank yroot))
            (vector-set! rank xroot (+ (vector-ref rank xroot) 1))))))

  (define sorted-edges (sort edges (lambda (a b) (< (car a) (car b)))))
  (define queries (for/list ([i (in-range (length edges))]) (list (list (list-ref edges i) i))))
  (define result (make-vector (length queries) #f))
  (define parent (build-vector n (lambda (i) i)))
  (define rank (build-vector n 0))
  (define idx 0)

  (for ([e (in-list sorted-edges)])
    (union parent rank (cadr e) (caddr e))
    (set! idx (+ idx 1))
    (for ([q (in-list queries)])
      (when (and (<= (car q) (car e)) (not (vector-ref result (cadr q))))
        (define u (cadr q))
        (define v (caddr q))
        (define root-u (find parent u))
        (define root-v (find parent v))
        (when (= root-u root-v)
          (vector-set! result (cadr q) #t))))

  (vector->list result))