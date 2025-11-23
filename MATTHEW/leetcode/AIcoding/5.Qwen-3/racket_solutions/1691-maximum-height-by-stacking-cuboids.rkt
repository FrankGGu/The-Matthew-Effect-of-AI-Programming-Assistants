#lang racket

(define (cmp a b)
  (cond
    [(< (car a) (car b)) #t]
    [(and (= (car a) (car b)) (< (cadr a) (cadr b))) #t]
    [(and (= (car a) (car b)) (= (cadr a) (cadr b)) (< (caddr a) (caddr b))) #t]
    [else #f]))

(define (max-height cuboids)
  (define sorted (sort cuboids cmp))
  (define n (length sorted))
  (define dp (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! dp i (list-ref sorted i) 3))
  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (and (>= (list-ref sorted i 0) (list-ref sorted j 0))
                 (>= (list-ref sorted i 1) (list-ref sorted j 1))
                 (>= (list-ref sorted i 2) (list-ref sorted j 2)))
        (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) (list-ref sorted i 2)))))))
  (apply max (vector->list dp)))

(define (main)
  (define input '((5 5 5) (6 6 6) (1 1 1)))
  (displayln (max-height input)))

(main)