(define (split-array-largest-sum nums k)
  (define (possible? max-sum)
    (define (helper nums k current-sum)
      (cond
        [(empty? nums) #t]
        [(= k 0) #f]
        [else
         (if (> (+ current-sum (car nums)) max-sum)
             (helper (cdr nums) (sub1 k) (car nums))
             (helper (cdr nums) k (+ current-sum (car nums))))]))
    (helper nums k 0))

  (define (binary-search left right)
    (if (<= left right)
        (let ((mid (quotient (+ left right) 2)))
          (if (possible? mid)
              (binary-search left (sub1 mid))
              (binary-search (add1 mid) right))
        )
        left))

  (let* ((total-sum (apply + nums))
         (max-num (apply max nums)))
    (binary-search max-num total-sum)))