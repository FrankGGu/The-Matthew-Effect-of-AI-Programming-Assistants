#lang racket

(define/contract (subtree-sizes n edges queries)
  (-> exact-integer? (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof exact-integer?))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define parent (make-vector n -1))
  (define size (make-vector n 1))

  (define (dfs u p)
    (vector-set! parent u p)
    (for ([v (vector-ref adj u)])
      (when (not (= v p))
        (dfs v u)
        (vector-set! size u (+ (vector-ref size u) (vector-ref size v))))))
    (void))

  (dfs 0 -1)

  (define res '())
  (for ([query queries])
    (let ([u (first query)]
          [v (second query)])
      (let ([old-parent (vector-ref parent u)])
        (when (not (= old-parent v))
          (let ([old-size (vector-ref size u)])
            (let loop ([p old-parent])
              (when (not (= p -1))
                (vector-set! size p (- (vector-ref size p) old-size))
                (loop (vector-ref parent p))))
            (vector-set! parent u v)
            (let loop ([p v])
              (when (not (= p -1))
                (vector-set! size p (+ (vector-ref size p) old-size))
                (loop (vector-ref parent p))))))))
    (set! res (cons (vector-ref size 0) res)))
  (reverse res))