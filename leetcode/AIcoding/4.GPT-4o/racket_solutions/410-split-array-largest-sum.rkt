(define (split-array-largest-sum nums k)
  (define (can-split? max-sum)
    (define (helper nums k)
      (if (or (null? nums) (= k 0))
          (if (null? nums) (zero? k) #f)
          (let loop ((sum 0) (count 0) (rest nums))
            (cond
              ((null? rest) (if (zero? count) #f (<= sum max-sum)))
              ((> (+ sum (car rest)) max-sum) (if (> count 0) (helper (cdr rest) (- k 1)) #f))
              (else (loop (+ sum (car rest)) count (cdr rest))))
          )))
    (helper nums k))

  (define (binary-search left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (can-split? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))

  (binary-search (apply max nums) (apply + nums)))