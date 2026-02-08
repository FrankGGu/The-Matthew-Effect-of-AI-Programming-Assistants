#lang racket

(require data/heap)

(define (minimum-time n relations time)
  (define graph (make-vector n '()))
  (define in-degree (make-vector n 0))
  (define max-time (make-vector n 0))

  (for ([rel relations])
    (let ([u (sub1 (first rel))]
          [v (sub1 (second rel))])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! in-degree v (add1 (vector-ref in-degree v)))))

  (define heap (make-heap (lambda (a b) (<= (car a) (car b)))))

  (for ([i (in-range n)])
    (when (zero? (vector-ref in-degree i))
      (heap-add! heap (cons (vector-ref time i) i))))

  (define result 0)

  (let loop ()
    (unless (heap-empty? heap)
      (let* ([current (heap-min heap)]
             [current-time (car current)]
             [u (cdr current)])
        (heap-remove-min! heap)
        (set! result (max result current-time))

        (for ([v (vector-ref graph u)])
          (vector-set! in-degree v (sub1 (vector-ref in-degree v)))
          (vector-set! max-time v (max (vector-ref max-time v) current-time))
          (when (zero? (vector-ref in-degree v))
            (heap-add! heap (cons (+ (vector-ref time v) (vector-ref max-time v)) v))))
        (loop))))

  result)