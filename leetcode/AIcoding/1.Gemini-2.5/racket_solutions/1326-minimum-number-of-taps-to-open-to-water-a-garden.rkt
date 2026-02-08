#lang racket

(define (min-taps n ranges-list)
  (let* ([num-taps (+ n 1)]
         (ranges (list->vector ranges-list)) ; Convert list to vector for O(1) access
         (dp (make-vector num-taps 0)))

    ;; Preprocessing: For each tap i, calculate its effective range [left, right]
    ;; and store the maximum 'right' for each 'left' in the dp array.
    ;; dp[j] will store the maximum reach of a tap whose left endpoint is j.
    (for ([i (in-range num-taps)])
      (let* ([r (vector-ref ranges i)]
             [left (max 0 (- i r))]
             [right (min n (+ i r))])
        (vector-set! dp left (max (vector-ref dp left) right))))

    ;; Greedy approach
    (let loop ([i 0] ; current position being considered in the garden
               [taps 0] ; number of taps opened so far
               [current-end 0] ; rightmost point watered by currently opened taps
               [farthest-reach-possible 0]) ; max reach achievable by any tap starting <= i
      (cond
        ;; If we have covered the entire garden
        [(>= current-end n) taps]
        ;; If we have iterated past the garden, and haven't covered it
        [(> i n) -1]
        ;; If we cannot reach the current point 'i' (implies a gap)
        [(> i current-end) -1]
        [else
         ;; Update farthest-reach-possible with the current tap's potential
         (let ([next-farthest-reach (max farthest-reach-possible (vector-ref dp i))])
           (if (= i current-end)
               ;; We are at the boundary of current coverage, need a new tap
               (if (<= next-farthest-reach current-end)
                   ;; Cannot extend coverage further, impossible
                   -1
                   ;; Open a new tap, update current-end to the new max reach
                   (loop (+ i 1)
                         (+ taps 1)
                         next-farthest-reach
                         next-farthest-reach))
               ;; We are still within current coverage, no new tap needed yet
               (loop (+ i 1)
                     taps
                     current-end
                     next-farthest-reach)))]))))