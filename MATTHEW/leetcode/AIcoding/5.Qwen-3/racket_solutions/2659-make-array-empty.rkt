(define (make-array-empty nums)
  (let loop ([nums nums] [count 0])
    (if (null? nums)
        count
        (let ([n (length nums)])
          (loop (filter (lambda (x) (not (= x (car nums)))) nums) (+ count n))))))