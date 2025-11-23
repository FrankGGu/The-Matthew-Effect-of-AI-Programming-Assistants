(define (num-rolls-to-equivalent-target target max-roll)
  (define (helper target max-roll)
    (cond [(= target 0) 0]
          [else
           (let ([min-rolls (quotient target max-roll)])
             (if (= (* min-rolls max-roll) target)
                 min-rolls
                 (+ min-rolls 1)))]))
  (helper target max-roll))