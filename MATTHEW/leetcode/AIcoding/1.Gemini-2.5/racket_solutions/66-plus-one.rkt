(define (plus-one digits)
  (define (plus-one-helper rev-digits carry acc)
    (cond
      [(empty? rev-digits)
       (if (= carry 1)
           (cons 1 acc)
           acc)]
      [else
       (let* ([d (first rev-digits)]
              [sum (+ d carry)]
              [new-digit (remainder sum 10)]
              [new-carry (quotient sum 10)])
         (plus-one-helper (rest rev-digits) new-carry (cons new-digit acc)))]))
  (plus-one-helper (reverse digits) 1 '()))