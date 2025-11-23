(define (peakIndexInMountainArray A)
  (define (binary-search left right)
    (if (= left right)
        left
        (let ((mid (+ left (quotient (- right left) 2))))
          (if (> (list-ref A mid) (list-ref A (+ mid 1)))
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))
  (binary-search 0 (- (length A) 1)))