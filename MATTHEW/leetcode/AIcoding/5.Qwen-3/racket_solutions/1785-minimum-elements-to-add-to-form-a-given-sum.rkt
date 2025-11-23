(define (min-add-to-form-target-sum nums target)
  (define (helper nums target sum)
    (cond [(null? nums) (if (>= sum target) 0 (- target sum))]
          [else (+ (helper (cdr nums) target (+ sum (car nums)))
                   (helper (cdr nums) target sum))]))
  (helper nums target 0))