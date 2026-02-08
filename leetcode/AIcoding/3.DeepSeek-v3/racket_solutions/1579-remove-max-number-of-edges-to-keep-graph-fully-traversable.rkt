#lang racket

(define (max-num-edges-to-remove n edges)
  (define parent1 (make-vector (+ n 1) 0))
  (define parent2 (make-vector (+ n 1) 0))
  (define (find parent u)
    (if (zero? (vector-ref parent u))
        u
        (begin
          (vector-set! parent u (find parent (vector-ref parent u)))
          (vector-ref parent u))))
  (define (union parent u v)
    (let ([pu (find parent u)]
          [pv (find parent v)])
      (when (not (equal? pu pv))
        (vector-set! parent pu pv)
        #t)))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! parent1 i 0)
    (vector-set! parent2 i 0))
  (define res 0)
  (define (process-edges type)
    (for ([edge (in-list edges)])
      (when (equal? (car edge) type)
        (let ([u (cadr edge)]
              [v (caddr edge)])
          (unless (union (if (equal? type 3) parent1 parent2) u v)
            (set! res (+ res 1))))))
  (process-edges 3)
  (vector-copy! parent2 1 parent1 1 n)
  (process-edges 1)
  (process-edges 2)
  (let ([root1 (find parent1 1)]
        [root2 (find parent2 1)])
    (for ([i (in-range 2 (+ n 1))])
      (when (or (not (equal? (find parent1 i) root1))
                (not (equal? (find parent2 i) root2)))
        (return -1)))
    res))