#lang racket

(define (shortest-distance-after-road-addition-queries n initial-edges queries)
  (define INF (expt 10 15))

  (define dist (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dist i (make-vector n)))

  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref dist i) j (if (= i j) 0 INF))))

  (for ([edge initial-edges])
    (define u (car edge))
    (define v (cadr edge))
    (define w (caddr edge))
    (vector-set! (vector-ref dist u) v (min (vector-ref (vector-ref dist u) v) w))
    (vector-set! (vector-ref dist v) u (min (vector-ref (vector-ref dist v) u) w)))

  (for ([k (in-range n)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (let ([d-ik (vector-ref (vector-ref dist i) k)]
              [d-kj (vector-ref (vector-ref dist k) j)])
          (when (and (< d-ik INF) (< d-kj INF))
            (let ([path-through-k (+ d-ik d-kj)])
              (vector-set! (vector-ref dist i) j
                           (min (vector-ref (vector-ref dist i) j) path-through-k))))))))

  (define results '())
  (for ([query queries])
    (define u-add (car query))
    (define v-add (cadr query))
    (define w-add (caddr query))
    (define s-query (list-ref query 3))
    (define t-query (list-ref query 4))

    (vector-set! (vector-ref dist u-add) v-add (min (vector-ref (vector-ref dist u-add) v-add) w-add))
    (vector-set! (vector-ref dist v-add) u-add (min (vector-ref (vector-ref dist v-add) u-add) w-add))

    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (let* ([path1 (vector-ref (vector-ref dist i) j)]
               [path2 (let ([d-iu (vector-ref (vector-ref dist i) u-add)]
                            [d-vj (vector-ref (vector-ref dist v-add) j)])
                        (if (and (< d-iu INF) (< d-vj INF))
                            (+ d-iu w-add d-vj)
                            INF))]
               [path3 (let ([d-iv (vector-ref (vector-ref dist i) v-add)]
                            [d-uj (vector-ref (vector-ref dist u-add) j)])
                        (if (and (< d-iv INF) (< d-uj INF))
                            (+ d-iv w-add d-uj)
                            INF))])
          (vector-set! (vector-ref dist i) j (min path1 path2 path3)))))

    (set! results (cons (vector-ref (vector-ref dist s-query) t-query) results)))

  (reverse results))