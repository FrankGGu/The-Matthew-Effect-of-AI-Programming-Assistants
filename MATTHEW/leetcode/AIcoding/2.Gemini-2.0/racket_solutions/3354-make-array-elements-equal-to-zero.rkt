(define (make-array-elements-equal-to-zero nums)
  (let loop ([nums nums] [prefix 0])
    (cond
      [(null? nums) #t]
      [(< (+ (car nums) prefix) 0) #f]
      [else (loop (cdr nums) (+ (car nums) prefix))])))