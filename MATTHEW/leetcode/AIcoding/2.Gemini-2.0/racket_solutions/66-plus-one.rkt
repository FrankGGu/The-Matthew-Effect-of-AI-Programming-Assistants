(define (plus-one digits)
  (define (plus-one-helper digits carry)
    (cond
      [(empty? digits)
       (if (= carry 0)
           empty
           (list carry))]
      [else
       (let* ([last-digit (last digits)]
              [new-digit (+ last-digit carry)]
              [new-carry (quotient new-digit 10)]
              [new-digit (remainder new-digit 10)]
              [rest (drop-right digits 1)])
         (append (plus-one-helper rest new-carry) (list new-digit)))]))
  (plus-one-helper digits 1))