#lang racket

(define (count-unreachable-nodes n edges)
  (define graph (make-hash))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (hash-update! graph u (λ (lst) (cons v lst)) '())
    (hash-update! graph v (λ (lst) (cons u lst)) '()))

  (define visited (make-hash))
  (define (dfs node)
    (when (not (hash-has-key? visited node))
      (hash-set! visited node #t)
      (for-each dfs (hash-ref graph node))))

  (define components '())
  (for ([i (in-range n)])
    (when (not (hash-has-key? visited i))
      (dfs i)
      (set! components (cons (hash-count visited) components))))

  (define total (apply + components))
  (define result 0)
  (for ([c components])
    (set! result (+ result (* c (- total c)))))
  (/ result 2))

(define (main)
  (define input (current-input-port))
  (define n (read input))
  (define edges (read input))
  (display (count-unreachable-nodes n edges)))

(main)