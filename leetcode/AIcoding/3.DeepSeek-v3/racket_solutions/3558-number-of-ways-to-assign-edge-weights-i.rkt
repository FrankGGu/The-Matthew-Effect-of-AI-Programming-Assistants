#lang racket

(define (number-of-ways n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define visited (make-vector n #f))
  (define parent (make-vector n -1))
  (define degree (make-vector n 0))

  (define (dfs u)
    (vector-set! visited u #t)
    (for ([v (vector-ref adj u)])
      (when (not (vector-ref visited v))
        (vector-set! parent v u)
        (vector-set! degree u (add1 (vector-ref degree u)))
        (dfs v)))

  (dfs 0)

  (define m (length edges))
  (define result 1)
  (define mod 1000000007)

  (for ([i (in-range 1 n)])
    (set! result (modulo (* result (factorial (vector-ref degree i))) mod)))

  (set! result (modulo (* result (factorial m)) mod))
  result)

(define (factorial x)
  (if (<= x 1) 1 (modulo (* x (factorial (sub1 x))) 1000000007)))