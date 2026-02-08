#lang racket

(define (number-of-ways n edges)
  (define mod 1000000007)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define parent (make-vector n -1))
  (define children (make-vector n '()))

  (define (build-tree u)
    (for ([v (vector-ref adj u)])
      (when (not (= v (vector-ref parent u)))
        (vector-set! parent v u)
        (vector-set! children u (cons v (vector-ref children u)))
        (build-tree v))))

  (build-tree 0)

  (define (count-subtree u)
    (let loop ([vs (vector-ref children u)]
               [total 1])
      (if (null? vs)
          total
          (let* ([v (car vs)]
                 [cnt (count-subtree v)])
            (loop (cdr vs) (* total (add1 cnt) mod))))))

  (define m (length edges))
  (define fact (make-vector (add1 m) 1))
  (for ([i (in-range 1 (add1 m))])
    (vector-set! fact i (modulo (* (vector-ref fact (sub1 i)) i) mod)))

  (define inv-fact (make-vector (add1 m) 1))
  (vector-set! inv-fact m (modular-inverse (vector-ref fact m) mod))
  (for ([i (in-range (sub1 m) -1 -1)])
    (vector-set! inv-fact i (modulo (* (vector-ref inv-fact (add1 i)) (add1 i)) mod))

  (define (comb a b)
    (if (or (< a b) (< b 0))
        0
        (modulo (* (vector-ref fact a) (vector-ref inv-fact b) (vector-ref inv-fact (- a b))) mod)))

  (define (modular-inverse x)
    (let loop ([a x]
               [b mod]
               [x0 0]
               [x1 1])
      (if (= a 1)
          x1
          (let ([q (quotient b a)])
            (loop (modulo b a) a x1 (modulo (- x0 (* q x1)) mod))))))

  (define total (count-subtree 0))
  (modulo (* total (vector-ref fact m)) mod))