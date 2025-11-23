#lang racket

(define (push-dominoes dominoes)
  (define n (string-length dominoes))
  (define right-forces (make-vector n +inf.0))
  (define left-forces (make-vector n +inf.0))
  (define result-chars (make-vector n #\.))

  (define current-r-force +inf.0)
  (for ([i (in-range n)])
    (define char (string-ref dominoes i))
    (cond
      [(char=? char #\R) (set! current-r-force 0)]
      [(char=? char #\L) (set! current-r-force +inf.0)]
      [(char=? char #\.)
       (when (not (eq? current-r-force +inf.0))
         (set! current-r-force (add1 current-r-force)))])
    (vector-set! right-forces i current-r-force))

  (define current-l-force +inf.0)
  (for ([i (in-range (sub1 n) -1 -1)])
    (define char (string-ref dominoes i))
    (cond
      [(char=? char #\L) (set! current-l-force 0)]
      [(char=? char #\R) (set! current-l-force +inf.0)]
      [(char=? char #\.)
       (when (not (eq? current-l-force +inf.0))
         (set! current-l-force (add1 current-l-force)))])
    (vector-set! left-forces i current-l-force))

  (for ([i (in-range n)])
    (define rf (vector-ref right-forces i))
    (define lf (vector-ref left-forces i))
    (cond
      [(= rf lf) (vector-set! result-chars i #\.)]
      [(< rf lf) (vector-set! result-chars i #\R)]
      [else (vector-set! result-chars i #\L)]))

  (vector->string result-chars))