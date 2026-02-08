(define (isBadVersion version)
  ;; This function is defined by LeetCode and is not implemented here.
)

(define (firstBadVersion n)
  (define (binary-search left right)
    (if (<= left right)
      (let ((mid (quotient (+ left right) 2)))
        (if (isBadVersion mid)
          (binary-search left (- mid 1))
          (binary-search (+ mid 1) right)))
      right))
  (binary-search 1 n))