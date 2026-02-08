#lang racket

(define (min-skips dist speed hours)
  (define n (length dist))
  ; Use Racket's built-in positive infinity for floating-point numbers
  (define POSITIVE-INFINITY +inf.0) 

  ; dp[i][j] = minimum time to travel i roads using j skips
  ; i from 0 to n
  ; j from 0 to n-1 (maximum skips for n roads is n-1)
  (define dp (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector n POSITIVE-INFINITY)))

  ; Base case: 0 time for 0 roads with 0 skips
  (vector-set! (vector-ref dp 0) 0 0.0)

  (for ([i (in-range 1 (+ n 1))]) ; i from 1 to n (number of roads considered)
    (define d_i (list-ref dist (sub1 i))) ; distance of current (i-th) road
    (define t_i (/ (exact->inexact d_i) (exact->inexact speed))) ; time for current road

    (for ([j (in-range n)]) ; j from 0 to n-1 (number of skips)
      ; Option 1: Don't skip the current (i-th) road
      ; This means j skips were used for the previous (i-1) roads.
      (define prev-time-no-skip (vector-ref (vector-ref dp (sub1 i)) j))
      (when (< prev-time-no-skip POSITIVE-INFINITY)
        (define time-before-current
          (if (< i n) ; If not the last road, apply ceiling
              (ceiling prev-time-no-skip)
              prev-time-no-skip))
        (define current-total-time (+ time-before-current t_i))
        (vector-set! (vector-ref dp i) j
                     (min (vector-ref (vector-ref dp i) j) current-total-time)))

      ; Option 2: Skip the current (i-th) road
      ; This means j-1 skips were used for the previous (i-1) roads.
      ; Only possible if j > 0.
      (when (> j 0)
        (define prev-time-with-skip (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))
        (when (< prev-time-with-skip POSITIVE-INFINITY)
          (define current-total-time (+ prev-time-with-skip t_i))
          (vector-set! (vector-ref dp i) j
                       (min (vector-ref (vector-ref dp i) j) current-total-time)))))

  ; Find the minimum number of skips
  (define target-hours (exact->inexact hours))
  (for ([j (in-range n)])
    (when (<= (vector-ref (vector-ref dp n) j) target-hours)
      (return-from min-skips j)))

  ; If no solution found
  -1)