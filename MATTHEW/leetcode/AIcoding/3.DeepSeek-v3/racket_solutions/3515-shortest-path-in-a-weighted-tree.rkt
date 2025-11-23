#lang racket

(define (shortest-path-tree n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (vector-set! adj u (cons (list v w) (vector-ref adj u)))
      (vector-set! adj v (cons (list u w) (vector-ref adj v)))))

  (define (dijkstra start)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0)
    (define heap (make-heap (λ (a b) (< (car a) (car b)))))
    (heap-add! heap (list 0 start))

    (let loop ()
      (unless (heap-empty? heap)
        (let ([current (heap-remove! heap)])
          (let ([d (car current)]
                [u (cadr current)])
            (when (= d (vector-ref dist u))
              (for ([neighbor (vector-ref adj u)])
                (let ([v (car neighbor)]
                      [w (cadr neighbor)])
                  (when (> (vector-ref dist v) (+ d w))
                    (vector-set! dist v (+ d w))
                    (heap-add! heap (list (vector-ref dist v) v)))))))
        (loop)))
    dist)

  (define dists (make-vector n #f))
  (for ([i (in-range n)])
    (vector-set! dists i (dijkstra i)))
  dists)