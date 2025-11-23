(define (zero-filled-subarray nums)
  (define (count-zero-subarrays length)
    (if (= length 0) 0
        (/ (* length (+ length 1)) 2)))
  (define (helper lst count)
    (cond
      [(null? lst) count]
      [(= (car lst) 0) (helper (cdr lst) (+ count 1))]
      [else (count-zero-subarrays count) (helper (cdr lst) 0)]))
  (+ (helper nums 0) (count-zero-subarrays 0)))

(define (numZeroFilledSubarrays nums)
  (zero-filled-subarray nums))