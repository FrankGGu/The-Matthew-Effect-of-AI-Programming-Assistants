(define (find-final-value nums original)
  (let loop ([nums nums] [original original])
    (cond
      [(empty? nums) original]
      [(member original nums) (loop nums (* 2 original))]
      [else (loop (cdr nums) original)])))