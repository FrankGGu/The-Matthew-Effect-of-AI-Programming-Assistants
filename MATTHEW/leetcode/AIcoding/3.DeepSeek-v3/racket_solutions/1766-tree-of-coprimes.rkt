#lang racket

(define (get-coprimes nums edges)
  (define n (length nums))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define result (make-vector n -1))
  (define visited (make-vector n #f))
  (define ancestors (make-hash))

  (define (dfs u depth)
    (vector-set! visited u #t)
    (define num (list-ref nums u))
    (define best-depth -1)
    (define best-ancestor -1)

    (for ([d (in-range 1 51)])
      (when (and (hash-has-key? ancestors d)
                 (= (gcd num d) 1))
        (let* ([ancestor-info (hash-ref ancestors d)]
                [ancestor-depth (car ancestor-info)]
                [ancestor-node (cdr ancestor-info)])
          (when (> ancestor-depth best-depth)
            (set! best-depth ancestor-depth)
            (set! best-ancestor ancestor-node)))))

    (vector-set! result u best-ancestor)

    (define prev-info (hash-ref ancestors num (cons -1 -1)))
    (hash-set! ancestors num (cons depth u))

    (for ([v (vector-ref adj u)])
      (when (not (vector-ref visited v))
        (dfs v (+ depth 1)))

    (if (= (car prev-info) -1)
        (hash-remove! ancestors num)
        (hash-set! ancestors num prev-info)))

  (dfs 0 0)
  (vector->list result))