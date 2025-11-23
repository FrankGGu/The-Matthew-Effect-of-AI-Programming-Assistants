(define (largest-altitude nums)
  (let loop ((nums nums) (current 0) (max 0))
    (if (null? nums)
        max
        (loop (cdr nums) (+ current (car nums)) (max max (+ current (car nums)))))))