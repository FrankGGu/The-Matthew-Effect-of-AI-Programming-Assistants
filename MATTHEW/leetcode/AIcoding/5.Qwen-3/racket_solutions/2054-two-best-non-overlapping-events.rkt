#lang racket

(define (max-events events)
  (define sorted (sort events (lambda (a b) (< (car a) (car b)))))
  (define n (length sorted))
  (define dp (make-vector n 0))
  (define (find-last-non-overlapping i)
    (let loop ([l 0] [r (- i 1)])
      (cond [(> l r) -1]
            [else
             (let ([mid (quotient (+ l r) 2)])
               (if (<= (caadr (vector-ref sorted mid)) (caar (vector-ref sorted i)))
                   (loop (+ mid 1) r)
                   (loop l (- mid 1))))])))
  (for ([i (in-range n)])
    (let ([start (caar (vector-ref sorted i))]
          [end (cadar (vector-ref sorted i))]
          [value (cadar (vector-ref sorted i))])
      (vector-set! dp i value)
      (let ([j (find-last-non-overlapping i)])
        (when (>= j 0)
          (vector-set! dp i (+ (vector-ref dp j) value))))))
  (apply max (vector->list dp)))