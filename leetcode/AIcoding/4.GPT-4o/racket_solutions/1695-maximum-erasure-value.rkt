(define (maximumErasureValue nums)
  (define (max-value start end)
    (let loop ((i start) (sum 0) (seen #f) (current-sum 0))
      (cond
        [(= i end) (max sum current-sum)]
        [(not (vector-ref seen (vector-ref nums i)))
         (vector-set! seen (vector-ref nums i) #t)
         (loop (+ i 1) sum (+ current-sum (vector-ref nums i)) seen)]
        [else
         (loop (+ start 1) (max sum current-sum) (vector-set! seen (vector-ref nums start) #f) (+ current-sum (vector-ref nums start)))])))
  (let ((n (vector-length nums)))
    (define seen (make-vector (apply max nums) #f))
    (max-value 0 n)))