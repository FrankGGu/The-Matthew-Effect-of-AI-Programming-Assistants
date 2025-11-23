(define (maximum-beautiful-towers max-heights)
  (let* ([n (length max-heights)]
         [max-heights-vec (list->vector max-heights)])

    (define (calculate-sum-for-peak peak-idx)
      (let ([current-sum 0])
        ;; Calculate heights and sum for the left (increasing) part, including the peak
        (let loop-left ([i peak-idx] [current-h (vector-ref max-heights-vec peak-idx)])
          (when (>= i 0)
            (let ([h (min current-h (vector-ref max-heights-vec i))])
              (set! current-sum (+ current-sum h))
              (loop-left (- i 1) h))))

        ;; Calculate heights and sum for the right (decreasing) part, excluding the peak
        ;; (as the peak's height is already accounted for in the left part)
        (let loop-right ([i (+ peak-idx 1)] [current-h (vector-ref max-heights-vec peak-idx)])
          (when (< i n)
            (let ([h (min current-h (vector-ref max-heights-vec i))])
              (set! current-sum (+ current-sum h))
              (loop-right (+ i 1) h))))
        current-sum))

    ;; Iterate through all possible peak indices and find the maximum sum
    (apply max (for/list ([j (in-range n)])
                 (calculate-sum-for-peak j)))))