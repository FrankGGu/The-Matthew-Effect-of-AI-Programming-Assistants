#lang racket

(require data/heap)

(define (minimum-weight n edges src1 src2 dest)
  (define adj (make-vector n '()))
  (define rev-adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
      (vector-set! rev-adj v (cons (cons u w) (vector-ref rev-adj v)))))

  (define (dijkstra start adj)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0)
    (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
    (heap-add! heap (cons 0 start))
    (let loop ()
      (when (not (heap-empty? heap))
        (let* ([current (heap-min heap)]
               [d (car current)]
               [u (cdr current)])
          (heap-remove! heap)
          (when (<= d (vector-ref dist u))
            (for ([neighbor (vector-ref adj u)])
              (let ([v (car neighbor)]
                    [w (cdr neighbor)])
                (when (> (vector-ref dist v) (+ d w))
                  (vector-set! dist v (+ d w))
                  (heap-add! heap (cons (vector-ref dist v) v))))))
          (loop))))
    dist)

  (define dist-src1 (dijkstra src1 adj))
  (define dist-src2 (dijkstra src2 adj))
  (define dist-dest (dijkstra dest rev-adj))

  (define min-weight +inf.0)
  (for ([i (in-range n)])
    (let ([total (+ (vector-ref dist-src1 i) (vector-ref dist-src2 i) (vector-ref dist-dest i))])
      (when (< total min-weight)
        (set! min-weight total))))

  (if (= min-weight +inf.0) -1 min-weight))