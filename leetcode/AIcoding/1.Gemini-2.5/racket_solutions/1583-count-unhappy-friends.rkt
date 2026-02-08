#lang racket

(define (count-unhappy-friends n preferences pairs)
  (define partner (make-vector n 0))
  (for-each (lambda (p)
              (define x (car p))
              (define y (cadr p))
              (vector-set! partner x y)
              (vector-set! partner y x))
            pairs)

  (define ranks (build-vector n (lambda (i) (make-vector n 0))))
  (for ([i (in-range n)])
    (define pref-list (list-ref preferences i))
    (for ([j (in-range (length pref-list))])
      (define preferred-friend (list-ref pref-list j))
      (vector-set! (vector-ref ranks i) preferred-friend j)))

  (define unhappy-count 0)
  (define is-unhappy (make-vector n #f))

  (for ([x (in-range n)])
    (when (not (vector-ref is-unhappy x))
      (define y (vector-ref partner x))
      (define rank-x-y (vector-ref (vector-ref ranks x) y))

      (for ([u (in-range n)])
        (when (and (not (= u x)) (not (= u y)))
          (define rank-x-u (vector-ref (vector-ref ranks x) u))
          (when (< rank-x-u rank-x-y)
            (define v (vector-ref partner u))
            (define rank-u-x (vector-ref (vector-ref ranks u) x))
            (define rank-u-v (vector-ref (vector-ref ranks u) v))
            (when (< rank-u-x rank-u-v)
              (vector-set! is-unhappy x #t)
              (set! unhappy-count (+ unhappy-count 1))
              (break))))))

  unhappy-count)