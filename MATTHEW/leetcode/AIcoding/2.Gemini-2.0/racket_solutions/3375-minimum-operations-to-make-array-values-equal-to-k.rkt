(define (min-operations nums k)
  (let* ((n (length nums))
         (greater-than-k (filter (lambda (x) (> x k)) nums))
         (count (length greater-than-k)))
    (if (zero? count)
        0
        (let ((sum-greater-than-k (apply + greater-than-k)))
          (if (= (remainder sum-greater-than-k k) 0)
              count
              -1)))))