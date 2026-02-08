#lang racket

(define (count-valid-paths n edges)
  (define primes (make-hash))
  (for ([i (in-range 2 (+ n 1))])
    (hash-set! primes i #t))
  (for ([i (in-range 2 (+ (floor (sqrt n)) 1))])
    (when (hash-ref primes i #f)
      (for ([j (in-range (* i i) (+ n 1) i)])
        (hash-remove! primes j))))

  (define adj (make-vector (+ n 1) '()))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (vector-set! adj u (cons v (vector-ref adj u)))
    (vector-set! adj v (cons u (vector-ref adj v))))

  (define result 0)

  (define (dfs node parent)
    (define cnt 0)
    (define prime? (hash-ref primes node #f))
    (for ([child (vector-ref adj node)])
      (when (not (equal? child parent))
        (define child-cnt (dfs child node))
        (when prime?
          (set! result (+ result (* child-cnt cnt))))
        (set! cnt (+ cnt child-cnt))
        (when prime?
          (set! result (+ result child-cnt)))))
    (if prime? 1 (add1 cnt)))

  (dfs 1 -1)
  result)