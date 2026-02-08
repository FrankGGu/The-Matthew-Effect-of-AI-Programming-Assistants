#lang racket

(define (find-power-of-k-size-subarrays nums k)
  (let* ((n (length nums)))
    (if (< n k)
        '()
        (for/list ([i (in-range (- n k -1))])
          (let* ((subarray (sublist nums i (+ i k))))
            (apply + subarray))))))