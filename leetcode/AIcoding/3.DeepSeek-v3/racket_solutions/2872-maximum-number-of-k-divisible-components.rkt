#lang racket

(define (max-k-divisible-components n edges values k)
  (define adj (make-vector n '()))
  (for ([e edges])
    (let ([u (car e)]
          [v (cadr e)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define res 0)

  (define (dfs u parent)
    (let ([sum (vector-ref values u)])
    (for ([v (vector-ref adj u)])
      (when (not (equal? v parent))
        (let ([child-sum (dfs v u)])
          (set! sum (+ sum child-sum))))
    (when (zero? (modulo sum k))
      (set! res (+ res 1))
      (set! sum 0))
    sum)

  (dfs 0 -1)
  res)