(define (find-subarrays-with-equal-sum nums)
  (define sums (hash))
  (for/or ([i (in-range 0 (- (length nums) 1))])
    (let ([sum (+ (list-ref nums i) (list-ref nums (+ i 1)))])
      (if (hash-has-key? sums sum)
          #t
          (begin
            (hash-set! sums sum #t)
            #f)))))