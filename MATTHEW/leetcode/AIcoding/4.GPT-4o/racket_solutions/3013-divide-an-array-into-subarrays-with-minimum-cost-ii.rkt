(define (min-cost subarrays)
  (define n (length subarrays))
  (define (min-cost-helper start end)
    (if (>= start end)
        0
        (let ((min-cost 0))
          (for ([i (in-range start (+ 1 end))])
            (set! min-cost (max min-cost (apply min (subarrays i)))))
          (+ min-cost (min-cost-helper (+ 1 start) end)))))
  (min-cost-helper 0 (- n 1)))

(define (divide-array arr k)
  (min-cost arr))