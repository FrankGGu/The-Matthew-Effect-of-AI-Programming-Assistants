#lang racket

(define (network-delay-time times n)
  (define graph (make-hash))
  (for ([t times])
    (define u (car t))
    (define v (cadr t))
    (define w (caddr t))
    (hash-set! graph u (cons (cons v w) (hash-ref graph u '()))))

  (define dist (make-hash))
  (for ([i (in-range 1 (add1 n))])
    (hash-set! dist i +inf.0))
  (hash-set! dist 1 0)

  (define pq (list (cons 0 1)))
  (set! pq (sort pq (lambda (a b) (< (car a) (car b)))))

  (define (extract-min)
    (let ([min-elt (car pq)])
      (set! pq (cdr pq))
      min-elt))

  (define (relax u v w)
    (when (< (+ (hash-ref dist u) w) (hash-ref dist v))
      (hash-set! dist v (+ (hash-ref dist u) w))
      (set! pq (cons (cons (hash-ref dist v) v) pq))
      (set! pq (sort pq (lambda (a b) (< (car a) (car b)))))))

  (while (not (null? pq))
    (let* ([current (extract-min)]
           [u (cdr current)]
           [d (car current)])
      (when (and (hash-has-key? graph u) (< d (hash-ref dist u)))
        (for ([neighbor (hash-ref graph u)])
          (relax u (car neighbor) (cdr neighbor)))))

  (define max-dist (apply max (hash-values dist)))
  (if (equal? max-dist +inf.0) -1 max-dist))