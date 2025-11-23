(define (calculate-tax brackets income)
  (let loop ([brackets brackets]
             [income income]
             [tax 0])
    (cond
      [(null? brackets) tax]
      [else
       (let ([upper-bound (car (car brackets))]
             [rate (cadr (car brackets))])
         (let ([taxable-income (min income upper-bound)])
           (let ([current-tax (* taxable-income rate)])
             (loop (cdr brackets)
                   (max 0 (- income taxable-income))
                   (+ tax current-tax)))))])))