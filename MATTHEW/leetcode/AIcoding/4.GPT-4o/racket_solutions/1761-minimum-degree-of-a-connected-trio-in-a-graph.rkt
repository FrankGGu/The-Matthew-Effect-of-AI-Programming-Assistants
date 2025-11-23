#lang racket

(define (min-trio-degree n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (define u (sub1 (first edge)))
      (define v (sub1 (second edge)))
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v))))

  (define degrees (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! degrees i (length (vector-ref adj i))))

  (define min-degree +inf.0)
  (for ([u (in-range n)])
    (for ([v (in-list (vector-ref adj u))])
      (for ([w (in-list (vector-ref adj v))])
        (when (and (not (= u v)) (not (= u w)) (not (= v w)) 
                   (member w (vector-ref adj u)))
          (set! min-degree (min min-degree (+ (vector-ref degrees u)
                                               (vector-ref degrees v)
                                               (vector-ref degrees w) 
                                               -6)))))))

  (if (= min-degree +inf.0) -1 min-degree))