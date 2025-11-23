(define (maximum-difference nums)
  (let loop ([nums nums]
             [min-val (car nums)]
             [max-diff -1])
    (cond [(empty? nums) max-diff]
          [else
           (let ([curr-val (car nums)])
             (if (> curr-val min-val)
                 (loop (cdr nums) min-val (max max-diff (- curr-val min-val)))
                 (loop (cdr nums) (min min-val curr-val) max-diff)))])))