(define (count-at-most nums k-val)
  (let* ([n (vector-length nums)]
         [left 0]
         [odd-count 0]
         [total-count 0])
    (for ([right (in-range n)])
      (when (odd? (vector-ref nums right))
        (set! odd-count (+ odd-count 1)))
      (while (> odd-count k-val)
        (when (odd? (vector-ref nums left))
          (set! odd-count (- odd-count 1)))
        (set! left (+ left 1)))
      (set! total-count (+ total-count (+ (- right left) 1))))
    total-count))

(define (number-of-nice-subarrays nums k)
  (let ([nums-vec (list->vector nums)])
    (- (count-at-most nums-vec k)
       (count-at-most nums-vec (- k 1)))))