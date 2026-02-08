#lang racket

(require data/gvector)

(struct DSU (parent rank)
  #:transparent)

(define (make-dsu n)
  (DSU (build-vector n (λ (i) i))
       (make-vector n 1)))

(define (dsu-find d u)
  (let ([parent (DSU-parent d)])
    (if (not (= (vector-ref parent u) u))
        (begin
          (vector-set! parent u (dsu-find d (vector-ref parent u)))
          (vector-ref parent u))
        u)))

(define (dsu-union d u v)
  (let ([u-root (dsu-find d u)]
        [v-root (dsu-find d v)])
    (unless (= u-root v-root)
      (let ([rank (DSU-rank d)])
        (if (> (vector-ref rank u-root) (vector-ref rank v-root))
            (begin
              (vector-set! (DSU-parent d) v-root u-root)
              (vector-set! rank u-root (+ (vector-ref rank u-root) (vector-ref rank v-root))))
            (begin
              (vector-set! (DSU-parent d) u-root v-root)
              (vector-set! rank v-root (+ (vector-ref rank u-root) (vector-ref rank v-root))))))))))

(struct Query (u v idx)
  #:transparent)

(define (distance-limited-paths-exist n edge-list queries)
  (define m (length edge-list))
  (define q (length queries))
  (define edges (list->vector edge-list))
  (define qs (list->vector (for/list ([query (in-list queries)]
                                      [i (in-naturals)])
                             (Query (first query) (second query) i))))
  (vector-sort! qs (λ (a b) (< (third (vector-ref edges (Query-idx a))) (third (vector-ref edges (Query-idx b))))))
  (vector-sort! edges (λ (a b) (< (third a) (third b))))
  (define dsu (make-dsu n))
  (define res (make-vector q #f))
  (define edge-idx 0)
  (for ([query (in-vector qs)])
    (let* ([limit (third (vector-ref edges (Query-idx query)))]
           [u (Query-u query)]
           [v (Query-v query)])
      (while (and (< edge-idx m) (< (third (vector-ref edges edge-idx)) limit))
        (let ([edge (vector-ref edges edge-idx)])
          (dsu-union dsu (first edge) (second edge))
          (set! edge-idx (add1 edge-idx))))
      (vector-set! res (Query-idx query) (= (dsu-find dsu u) (dsu-find dsu v)))))
  (vector->list res))