(define (max-alternating-subsequence-sum nums)
  (define (helper i even? total)
    (cond [(= i (length nums)) total]
          [else
           (let ([current (list-ref nums i)])
             (if even?
                 (helper (+ i 1) #f (max total (+ total current)))
                 (helper (+ i 1) #t (max total (- total current)))))]))
  (helper 0 #t 0))