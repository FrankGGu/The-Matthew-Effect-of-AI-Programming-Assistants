(define (max-sales days k)
  (let* ([n (length days)]
         [sums (make-vector (+ n 1) 0)])
    (for/fold ([i 1])
              ([day (in-list days)])
      (vector-set! sums i (+ (vector-ref sums (- i 1)) day))
      (+ i 1))
    (let loop ([i 0] [max-sum 0])
      (if (> (+ i k) n)
          max-sum
          (let ([current-sum (- (vector-ref sums (+ i k)) (vector-ref sums i))])
            (loop (+ i 1) (max max-sum current-sum)))))))