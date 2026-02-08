(define (return-to-boundaryCount nums)
  (let loop ([nums nums] [count 0] [current-pos 0])
    (cond
      [(null? nums) count]
      [(zero? (+ current-pos (car nums)))
       (loop (cdr nums) (+ count 1) (+ current-pos (car nums)))]
      [else
       (loop (cdr nums) count (+ current-pos (car nums)))])))