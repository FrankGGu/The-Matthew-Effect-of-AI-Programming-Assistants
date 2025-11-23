#lang racket

(require data/heap)

(define (maximum-weight n edges)
  (define adj (make-vector n '()))
  (define degree (make-vector n 0))
  (define weight (make-vector n 0))

  (for ([e edges])
    (define u (car e))
    (define v (cadr e))
    (define w (caddr e))
    (vector-set! adj u (cons (list v w) (vector-ref adj u)))
    (vector-set! adj v (cons (list u w) (vector-ref adj v)))
    (vector-set! degree u (add1 (vector-ref degree u)))
    (vector-set! degree v (add1 (vector-ref degree v)))
    (vector-set! weight u (+ (vector-ref weight u) w))
    (vector-set! weight v (+ (vector-ref weight v) w)))

  (define heap (make-heap (lambda (a b) (> (car a) (car b)))))

  (for ([i (in-range n)])
    (when (> (vector-ref degree i) 1)
      (heap-add! heap (cons (vector-ref weight i) i))))

  (define res 0)
  (for ([i (in-range (- n 2))])
    (define node (cdr (heap-remove-min! heap)))
    (res (+ res (vector-ref weight node)))
    (vector-set! degree node (sub1 (vector-ref degree node)))
    (for ([neighbor-info (vector-ref adj node)])
      (define neighbor (car neighbor-info))
      (define w (cadr neighbor-info))
      (unless (= (vector-ref degree neighbor) 1)
        (vector-set! weight neighbor (- (vector-ref weight neighbor) w))
        (vector-set! degree neighbor (sub1 (vector-ref degree neighbor)))
        (when (> (vector-ref degree neighbor) 1)
          (heap-add! heap (cons (vector-ref weight neighbor) neighbor))))))

  res)