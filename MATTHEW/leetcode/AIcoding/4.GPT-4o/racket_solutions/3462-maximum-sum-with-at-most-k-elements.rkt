(define (maxSumKElements nums k)
  (define (helper lst k)
    (if (or (null? lst) (zero? k))
        0
        (max (+ (car lst) (helper (cdr lst) (- k 1)))
             (helper (cdr lst) k))))
  (helper nums k))

(define (maxSum(nums k))
  (maxSumKElements nums k))