(define (rob nums)
  (cond [(null? nums) 0]
        [(null? (cdr nums)) (car nums)]
        [else
         (let loop ([i 0] [prev-prev 0] [prev 0])
           (if (>= i (length nums))
               prev
               (let ([current (+ (list-ref nums i) prev-prev)])
                 (loop (+ i 1) prev current))))]))