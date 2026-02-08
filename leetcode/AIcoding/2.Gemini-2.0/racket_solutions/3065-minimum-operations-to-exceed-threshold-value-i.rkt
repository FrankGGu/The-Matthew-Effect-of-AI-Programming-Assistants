(define (minOperations nums k)
  (let loop ((count 0) (nums nums))
    (cond
      [(empty? nums) count]
      [(every? (lambda (x) (>= x k)) nums) count]
      [else
       (let* ([min1 (apply min nums)]
              [nums1 (remove (lambda (x) (= x min1)) nums)]
              [min2 (if (empty? nums1) min1 (apply min nums1))]
              [new-val (+ min1 (* 2 min2))])
         (loop (+ 1) (append (list new-val) (remove (lambda (x) (or (= x min1) (= x min2))) nums))))])))