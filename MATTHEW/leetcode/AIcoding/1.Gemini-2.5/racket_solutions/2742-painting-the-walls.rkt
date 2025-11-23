#lang racket

(define (paint-walls cost time)
  (define n (length cost))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (for ([i (in-range n)])
    (define current-cost (list-ref cost i))
    (define walls-covered (+ (list-ref time i) 1)) ; The current wall + time[i] free walls

    (for ([j (in-range n -1 -1)]) ; Iterate j from n down to 0
      (when (not (eq? (vector-ref dp j) +inf.0)) ; Only consider reachable states
        (define new-total-walls (min n (+ j walls-covered)))
        (vector-set! dp new-total-walls
                     (min (vector-ref dp new-total-walls)
                          (+ (vector-ref dp j) current-cost))))))
  (vector-ref dp n))