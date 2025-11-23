#lang racket

(define (max-unique-subarray-sum-after-deletion nums)
  (define (max-subarray-sum arr)
    (let loop ([i 0] [current 0] [max-sum 0])
      (cond [(= i (length arr)) max-sum]
            [else
             (let ([current (+ current (list-ref arr i))])
               (if (> current 0)
                   (loop (+ i 1) current (max max-sum current))
                   (loop (+ i 1) 0 max-sum))))]))

  (define (get-unique-subarrays nums)
    (let loop ([i 0] [seen #hash()] [subarrays '()])
      (cond [(= i (length nums)) subarrays]
            [else
             (if (hash-has-key? seen (list-ref nums i))
                 (loop (+ i 1) #hash() '())
                 (loop (+ i 1) (hash-set seen (list-ref nums i) #t) (cons (list-ref nums i) subarrays)))]))

  (define unique-subarrays (reverse (get-unique-subarrays nums)))
  (if (null? unique-subarrays)
      0
      (max-subarray-sum unique-subarrays)))