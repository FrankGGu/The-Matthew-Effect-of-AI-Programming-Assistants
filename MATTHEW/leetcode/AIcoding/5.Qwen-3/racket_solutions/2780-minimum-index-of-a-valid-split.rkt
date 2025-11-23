(define (split-array nums)
  (let loop ([left-sum 0] [right-sum 0] [i 0])
    (if (= i (length nums))
        -1
        (let ([current (list-ref nums i)])
          (if (and (= left-sum right-sum) (< i (- (length nums) 1)))
              i
              (loop (+ left-sum current) (- right-sum current) (+ i 1)))))))