(define (delete-and-earn nums)
  (let* ([max-num (apply max nums)]
         [count (make-vector (+ max-num 1) 0)])
    (for-each (lambda (n) (vector-set! count n (+ (vector-ref count n) 1))) nums)
    (let loop ([i 2] [prev (vector-ref count 1)] [curr (vector-ref count 0)])
      (if (> i max-num)
          (max prev curr)
          (loop (+ i 1) curr (+ curr (vector-ref count i)))))))