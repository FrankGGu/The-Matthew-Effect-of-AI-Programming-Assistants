#lang racket

(define (number-of-ways edges)
  (define n (add1 (length edges)))
  (define adj (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (hash-set! adj u (cons v (hash-ref adj u '())))
       (hash-set! adj v (cons u (hash-ref adj v '())))))
   edges)
  (define (count node parent)
    (let ([children (filter (lambda (x) (not (= x parent))) (hash-ref adj node))])
      (if (null? children)
          1
          (apply * (map (lambda (child) (count child node)) children)))))
  (define (dfs node parent)
    (let ([children (filter (lambda (x) (not (= x parent))) (hash-ref adj node))])
      (if (null? children)
          1
          (let ([prod (apply * (map (lambda (child) (dfs child node)) children))])
            (if (= (length children) 1)
                prod
                (* prod (count (car children) node) (count (cadr children) node)))))))
  (define (check node parent)
    (let ([children (filter (lambda (x) (not (= x parent))) (hash-ref adj node))])
      (if (null? children)
          #t
          (andmap (lambda (child) (check child node)) children)))
  (if (check 0 -1)
      (dfs 0 -1)
      0))