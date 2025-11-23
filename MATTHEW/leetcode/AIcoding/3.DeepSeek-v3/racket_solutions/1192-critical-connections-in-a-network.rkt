#lang racket

(define (critical-connections n connections)
  (define graph (make-vector n '()))
  (define disc (make-vector n -1))
  (define low (make-vector n -1))
  (define time 0)
  (define result '())

  (for ([conn connections])
    (let ([u (first conn)] [v (second conn)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define (dfs u parent)
    (vector-set! disc u time)
    (vector-set! low u time)
    (set! time (add1 time))
    (for ([v (vector-ref graph u)])
      (cond
        [(= v parent) (void)]
        [(< (vector-ref disc v) 0)
         (dfs v u)
         (vector-set! low u (min (vector-ref low u) (vector-ref low v)))
         (when (> (vector-ref low v) (vector-ref disc u))
           (set! result (cons (list u v) result)))]
        [else
         (vector-set! low u (min (vector-ref low u) (vector-ref disc v)))]))))

  (dfs 0 -1)
  (reverse result))