#lang racket

(define (most-profitable-path edges bob-amount)
  (define n (add1 (length edges)))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define bob-time (make-vector n -1))
  (define (dfs-bob u parent time)
    (vector-set! bob-time u time)
    (if (= u 0)
        #t
        (for ([v (vector-ref adj u)] #:when (not (= v parent)))
          (if (dfs-bob v u (add1 time))
              #t
              (vector-set! bob-time u -1))))))
  (dfs-bob bob-amount -1 0)

  (define max-profit -inf.0)
  (define (dfs-alice u parent alice-time current-profit)
    (define new-time (add1 alice-time))
    (define bob-t (vector-ref bob-time u))
    (define new-profit
      (cond
        [(or (= bob-t -1) (> alice-time bob-t)) current-profit]
        [(= alice-time bob-t) (/ current-profit 2)]
        [else 0]))
    (when (and (= (length (vector-ref adj u)) 1) (not (= u 0)))
      (set! max-profit (max max-profit new-profit)))
    (for ([v (vector-ref adj u)] #:when (not (= v parent)))
      (dfs-alice v u new-time new-profit)))

  (dfs-alice 0 -1 0 0)
  (inexact->exact (floor max-profit)))