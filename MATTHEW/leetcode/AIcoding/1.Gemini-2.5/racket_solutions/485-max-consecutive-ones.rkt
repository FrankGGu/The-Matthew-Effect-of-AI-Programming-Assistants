(define (find-max-consecutive-ones nums)
  (let loop ((nums nums)
             (current-max 0)
             (overall-max 0))
    (cond
      ((null? nums) overall-max)
      ((= (car nums) 1)
       (loop (cdr nums) (+ current-max 1) (max overall-max (+ current-max 1))))
      (else
       (loop (cdr nums) 0 (max overall-max current-max))))))