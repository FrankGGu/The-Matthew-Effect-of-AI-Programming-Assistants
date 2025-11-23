#lang racket

(define (solve n parents nums)
  (define adj (make-vector n '()))
  (define ans (make-vector n -1))
  (define node-depth (make-vector n 0))

  (for ([i (in-range 1 n)])
    (define p (list-ref parents i))
    (vector-set! adj p (cons i (vector-ref adj p)))
    (vector-set! adj i (cons p (vector-ref adj i))))

  (define ancestor-info (make-vector 51 '()))

  (define (dfs u p d)
    (vector-set! node-depth u d)

    (define current-num (list-ref nums u))
    (define best-ancestor-node -1)
    (define max-depth -1)

    (for ([val (in-range 1 51)])
      (when (= (gcd current-num val) 1)
        (define stack-for-val (vector-ref ancestor-info val))
        (when (not (null? stack-for-val))
          (define ancestor-record (car stack-for-val))
          (define ancestor-d (car ancestor-record))
          (define ancestor-node (cadr ancestor-record))
          (when (> ancestor-d max-depth)
            (set! max-depth ancestor-d)
            (set! best-ancestor-node ancestor-node)))))

    (vector-set! ans u best-ancestor-node)

    (define old-stack-for-current-num (vector-ref ancestor-info current-num))
    (vector-set! ancestor-info current-num (cons (list d u) old-stack-for-current-num))

    (for ([v (vector-ref adj u)])
      (when (not (= v p))
        (dfs v u (+ d 1))))

    (vector-set! ancestor-info current-num old-stack-for-current-num))

  (dfs 0 -1 0)

  (vector->list ans))