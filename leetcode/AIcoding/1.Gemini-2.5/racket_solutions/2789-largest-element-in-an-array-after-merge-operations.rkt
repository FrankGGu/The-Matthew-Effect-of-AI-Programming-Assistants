(define (largest-element-in-array-after-merge-operations nums)
  (define n (length nums))
  (if (= n 0)
      0
      (let* ([vec (list->vector nums)]
             [last-idx (- n 1)])
        (let loop ([i (- n 2)]
                   [max-val (vector-ref vec last-idx)]
                   [current-merged-val (vector-ref vec last-idx)])
          (if (< i 0)
              max-val
              (let ([num (vector-ref vec i)])
                (if (<= num current-merged-val)
                    (loop (- i 1)
                          (max max-val (+ num current-merged-val))
                          (+ num current-merged-val))
                    (loop (- i 1)
                          (max max-val num)
                          num))))))))