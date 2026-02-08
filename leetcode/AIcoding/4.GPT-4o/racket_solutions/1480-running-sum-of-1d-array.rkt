(define (runningSum nums)
  (let loop ((nums nums) (acc 0) (result '()))
    (if (null? nums)
        (reverse result)
        (loop (cdr nums) (+ acc (car nums)) (cons (+ acc (car nums)) result)))))

(runningSum '(1 2 3 4)) ; Example call for testing