#lang racket

(define (maximize-target-nodes parents target-nodes)
  (define n (length parents))
  (define children (make-vector n '()))
  (for ([i (in-range 1 n)])
    (define p (list-ref parents i))
    (vector-set! children p (cons i (vector-ref children p))))

  (define target-set (list->set target-nodes))

  (define (dfs u)
    (define res 0)
    (for ([v (vector-ref children u)])
      (define r (dfs v))
      (when (or (set-member? target-set v) (> r 0))
        (set! res (+ res r 1)))
    res)

  (define total (for/sum ([node target-nodes])
                  (dfs node)))

  (define max-increase 0)

  (define (find-max u)
    (define res 0)
    (for ([v (vector-ref children u)])
      (define r (find-max v))
      (when (or (set-member? target-set v) (> r 0))
        (set! res (+ res r 1)))
    (when (set-member? target-set u)
      (set! max-increase (max max-increase res)))
    res)

  (for ([node target-nodes])
    (find-max node))

  (+ total max-increase))