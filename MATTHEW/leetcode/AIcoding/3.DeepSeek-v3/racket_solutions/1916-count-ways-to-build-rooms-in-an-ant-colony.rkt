#lang racket

(define MOD 1000000007)

(define (pow a b)
  (cond
    [(zero? b) 1]
    [(even? b) (modulo (sqr (pow a (quotient b 2))) MOD)]
    [else (modulo (* a (pow a (sub1 b))) MOD)]))

(define (inverse x)
  (pow x (- MOD 2)))

(define (count-ways prev-rooms)
  (define n (length prev-rooms))
  (define fact (make-vector (add1 n) 1))
  (define inv-fact (make-vector (add1 n) 1))
  (for ([i (in-range 1 (add1 n))])
    (vector-set! fact i (modulo (* (vector-ref fact (sub1 i)) i) MOD))
    (vector-set! inv-fact i (inverse (vector-ref fact i)))))

  (define adj (make-vector n '()))
  (for ([i (in-range 1 n)])
    (vector-set! adj (list-ref prev-rooms i) 
                  (cons i (vector-ref adj (list-ref prev-rooms i))))))

  (define size (make-vector n 1))
  (define dp (make-vector n 1))

  (define (dfs u)
    (for ([v (vector-ref adj u)])
      (dfs v)
      (vector-set! size u (+ (vector-ref size u) (vector-ref size v)))
      (vector-set! dp u 
                   (modulo (* (vector-ref dp u) 
                              (vector-ref dp v) 
                              (vector-ref inv-fact (vector-ref size v))) 
                           MOD)))
    (vector-set! dp u (modulo (* (vector-ref dp u) 
                                 (vector-ref fact (sub1 (vector-ref size u)))) 
                          MOD)))

  (dfs 0)
  (vector-ref dp 0))