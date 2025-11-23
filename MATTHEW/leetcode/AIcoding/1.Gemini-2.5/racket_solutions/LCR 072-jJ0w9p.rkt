(define (my-sqrt x)
  (cond
    [(< x 2) x]
    [else
     (let loop ((low 1) (high x) (ans 0))
       (if (> low high)
           ans
           (let* ((mid (+ low (quotient (- high low) 2)))
                  (mid-squared (* mid mid)))
             (if (= mid-squared x)
                 mid
                 (if (< mid-squared x)
                     (loop (+ mid 1) high mid)
                     (loop low (- mid 1) ans))))))]))