(define (min-cost-to-remove-array-elements nums)
  (define (helper nums cost)
    (cond [(null? nums) cost]
          [(= (length nums) 1) (+ cost (car nums))]
          [else
           (let* ([left (car nums)]
                  [right (last nums)]
                  [cost-left (+ cost left)]
                  [cost-right (+ cost right)])
             (if (< cost-left cost-right)
                 (helper (cdr nums) cost-left)
                 (helper (reverse (cdr (reverse nums))) cost-right)))]))
  (helper nums 0))