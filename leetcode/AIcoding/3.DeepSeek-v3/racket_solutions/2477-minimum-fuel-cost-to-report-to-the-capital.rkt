#lang racket

(define (minimum-fuel-cost roads seats)
  (define n (add1 (length roads)))
  (define adj (make-vector n '()))
  (for ([road roads])
    (define u (car road))
    (define v (cadr road))
    (vector-set! adj u (cons v (vector-ref adj u)))
    (vector-set! adj v (cons u (vector-ref adj v))))

  (define fuel 0)

  (define (dfs node parent)
    (define people 1)
    (for ([neighbor (vector-ref adj node)])
      (when (not (equal? neighbor parent))
        (define p (dfs neighbor node))
        (set! people (+ people p))
        (set! fuel (+ fuel (ceiling (/ p seats)))))
    people)

  (dfs 0 -1)
  fuel)