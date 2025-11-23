#lang racket

(define (minimize-max-edge-weight n edges)
  (define (find parent x)
    (if (= parent x)
        x
        (find parent (vector-ref parent x))))

  (define (union parent x y)
    (let ([root-x (find parent x)]
          [root-y (find parent y)])
      (if (= root-x root-y)
          #f
          (begin
            (vector-set! parent root-y root-x)
            #t))))

  (define (compare a b)
    (< (car a) (car b)))

  (define sorted-edges (sort edges compare))

  (define parent (build-vector n values))

  (define (dfs u target visited)
    (when (not (vector-ref visited u))
      (vector-set! visited u #t)
      (for-each (lambda (v)
                  (when (not (vector-ref visited v))
                    (dfs v target visited)))
                (filter (lambda (e) (or (and (= (car e) u) (= (cadr e) target))
                                        (and (= (cadr e) u) (= (car e) target))))
                        sorted-edges))))

  (define (is-connected u v)
    (define visited (make-vector n #f))
    (dfs u v visited)
    (vector-ref visited v))

  (define (binary-search low high)
    (if (> low high)
        (vector-ref parent 0)
        (let ([mid (quotient (+ low high) 2)])
          (define temp-parent (vector-copy parent))
          (for-each (lambda (e)
                      (when (<= (car e) mid)
                        (union temp-parent (cadr e) (caddr e))))
                    sorted-edges)
          (if (is-connected 0 (- n 1))
              (binary-search low (sub1 mid))
              (binary-search (add1 mid) high)))))

  (binary-search 0 (apply max (map car edges))))