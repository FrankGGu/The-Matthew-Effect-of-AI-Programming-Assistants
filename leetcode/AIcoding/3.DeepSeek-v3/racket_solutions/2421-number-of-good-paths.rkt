#lang racket

(define (number-of-good-paths vals edges)
  (define n (length vals))
  (define parent (make-vector n 0))
  (define count (make-hash))
  (define result 0)

  (for ([i (in-range n)])
    (vector-set! parent i i)
    (hash-set! count i (make-hash))
    (hash-set! (hash-ref count i) (list-ref vals i) 1))

  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (begin
          (vector-set! parent u (find (vector-ref parent u)))
          (vector-ref parent u))))

  (define edges-sorted
    (sort edges (lambda (a b)
                  (<= (max (list-ref vals (car a)) (list-ref vals (cadr a)))
                      (max (list-ref vals (car b)) (list-ref vals (cadr b)))))))

  (for ([edge edges-sorted])
    (define u (car edge))
    (define v (cadr edge))
    (define root-u (find u))
    (define root-v (find v))
    (when (not (equal? root-u root-v))
      (define val-u (list-ref vals root-u))
      (define val-v (list-ref vals root-v))
      (define max-val (max val-u val-v))
      (if (> val-u val-v)
          (begin
            (vector-set! parent root-v root-u)
            (for ([(val cnt) (in-hash (hash-ref count root-v))])
              (hash-update! (hash-ref count root-u) val
                            (lambda (old) (+ old cnt)) 0))
            (hash-clear! (hash-ref count root-v)))
          (begin
            (vector-set! parent root-u root-v)
            (for ([(val cnt) (in-hash (hash-ref count root-u))])
              (hash-update! (hash-ref count root-v) val
                            (lambda (old) (+ old cnt)) 0))
            (hash-clear! (hash-ref count root-u)))))
    (define root (find u))
    (define current-val (max (list-ref vals u) (list-ref vals v)))
    (set! result (+ result (hash-ref (hash-ref count root) current-val 0))))

  (+ result n))