#lang racket

(define (min-cost-zigzag nums)
  (let* ((n (vector-length nums)))
    (if (<= n 1)
        0
        (min (calculate-cost nums #t) ; Calculate cost for pattern: valley at even indices (e.g., < > < > ...)
             (calculate-cost nums #f))))) ; Calculate cost for pattern: peak at even indices (e.g., > < > < ...)

(define (calculate-cost nums start-even-valley?)
  (let* ((n (vector-length nums))
         (total-cost 0)
         (temp-arr (vector-copy nums))) ; Create a mutable copy to simulate modifications
    (for ([i (in-range n)])
      (let* ((is-valley-pos (if start-even-valley? (even? i) (odd? i))))
        (if is-valley-pos
            ; current-val at index i should be a valley: current-val < left-val and current-val < right-val
            (let* ((left-val (if (zero? i) +inf.0 (vector-ref temp-arr (- i 1))))
                   (right-val (if (= i (- n 1)) +inf.0 (vector-ref temp-arr (+ i 1))))
                   (current-val (vector-ref temp-arr i))
                   (target-ceiling (min left-val right-val)))
              (when (>= current-val target-ceiling)
                (let ((diff (- current-val target-ceiling -1))) ; Amount to decrease current-val
                  (set! total-cost (+ total-cost diff))
                  (vector-set! temp-arr i (- current-val diff))))) ; Apply decrease to temp-arr
            ; current-val at index i should be a peak: current-val > left-val and current-val > right-val
            (let* ((left-val (if (zero? i) -inf.0 (vector-ref temp-arr (- i 1))))
                   (right-val (if (= i (- n 1)) -inf.0 (vector-ref temp-arr (+ i 1))))
                   (current-val (vector-ref temp-arr i)))
              (let* ((cost-to-reduce-left 0)
                     (cost-to-reduce-right 0))
                (when (>= left-val current-val)
                  (set! cost-to-reduce-left (- left-val current-val -1)))
                (when (>= right-val current-val)
                  (set! cost-to-reduce-right (- right-val current-val -1)))

                (when (> cost-to-reduce-left 0)
                  (set! total-cost (+ total-cost cost-to-reduce-left))
                  (vector-set! temp-arr (- i 1) (- (vector-ref temp-arr (- i 1)) cost-to-reduce-left)))

                (when (> cost-to-reduce-right 0)
                  (set! total-cost (+ total-cost cost-to-reduce-right))
                  (vector-set! temp-arr (+ i 1) (- (vector-ref temp-arr (+ i 1)) cost-to-reduce-right))))))))
    total-cost))