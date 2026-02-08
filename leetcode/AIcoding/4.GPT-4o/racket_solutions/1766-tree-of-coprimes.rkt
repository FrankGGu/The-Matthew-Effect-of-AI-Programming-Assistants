#lang racket

(define (getCoprimes nums edges)
  (define n (length nums))
  (define graph (make-vector n '()))
  (for ([i (in-range (length edges))])
    (define u (first (list-ref edges i)))
    (define v (second (list-ref edges i)))
    (vector-set! graph u (cons v (vector-ref graph u)))
    (vector-set! graph v (cons u (vector-ref graph v))))

  (define (gcd a b)
    (if (= b 0) a (gcd b (modulo a b))))

  (define coprime-ancestor (make-vector n -1))
  (define result (make-vector n -1))

  (define (dfs node parent level)
    (for ([neighbor (vector-ref graph node)])
      (unless (= neighbor parent)
        (if (= (gcd (vector-ref nums node) (vector-ref nums neighbor)) 1)
            (begin
              (vector-set! coprime-ancestor node neighbor)
              (vector-set! result node neighbor))
            (begin
              (vector-set! coprime-ancestor node (vector-ref coprime-ancestor neighbor))
              (if (not (= (vector-ref coprime-ancestor neighbor) -1))
                  (vector-set! result node (vector-ref coprime-ancestor neighbor)))))
        (dfs neighbor node level)))

  (for ([i (in-range n)])
    (unless (vector-ref coprime-ancestor i)
      (dfs i -1 i)))

  (vector->list result))

(getCoprimes '(2 3 6 5 10) '((0 1) (1 2) (1 3) (3 4)))