(define (triangle-number nums)
  (let* ([positive-nums (filter (lambda (x) (> x 0)) nums)]
         [sorted-nums (sort positive-nums <)]
         [len (length sorted-nums)]
         [vec (list->vector sorted-nums)])
    (if (< len 3)
        0
        (let outer-loop ([i (- len 1)] [total-count 0])
          (if (< i 2)
              total-count
              (let inner-loop ([left 0] [right (- i 1)] [current-loop-count total-count])
                (if (>= left right)
                    (outer-loop (- i 1) current-loop-count)
                    (let ([num-i (vector-ref vec i)]
                          [num-left (vector-ref vec left)]
                          [num-right (vector-ref vec right)])
                      (if (> (+ num-left num-right) num-i)
                          (inner-loop left (- right 1) (+ current-loop-count (- right left)))
                          (inner-loop (+ left 1) right current-loop-count))))))))))