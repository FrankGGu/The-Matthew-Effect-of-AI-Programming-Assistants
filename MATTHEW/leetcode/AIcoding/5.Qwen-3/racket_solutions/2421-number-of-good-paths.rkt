#lang racket

(define (number-of-good-paths vals edges)
  (define n (length vals))
  (define adj (make-vector n '()))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (vector-set! adj u (cons v (vector-ref adj u)))
       (vector-set! adj v (cons u (vector-ref adj v)))))
   edges)

  (define parent (build-list n values))
  (define (find x)
    (if (= x (vector-ref parent x))
        x
        (let ([p (find (vector-ref parent x))])
          (vector-set! parent x p)
          p)))

  (define (union x y)
    (let ([xroot (find x)] [yroot (find y)])
      (when (not (= xroot yroot))
        (vector-set! parent yroot xroot))))

  (define val->nodes (make-hash))
  (for ([i (in-range n)])
    (hash-update! val->nodes (list-ref vals i) (λ (lst) (cons i lst)) '()))

  (define nodes (sort (hash-values val->nodes) (λ (a b) (> (length a) (length b))))
  (for ([node-list nodes])
    (for ([u node-list])
      (for ([v (vector-ref adj u)])
        (when (= (list-ref vals u) (list-ref vals v))
          (union u v))))

  (define count (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (hash-update! count root add1 0)))

  (apply + (hash-values count)))