(define (summary-ranges nums)
  (define (helper nums start current acc)
    (cond
      [(empty? nums)
       (if (= start current)
           (cons (number->string start) acc)
           (cons (~a start "->" current) acc))]
      [(= (car nums) (+ current 1))
       (helper (cdr nums) start (car nums) acc)]
      [else
       (if (= start current)
           (helper (cdr nums) (car nums) (car nums) (cons (number->string start) acc))
           (helper (cdr nums) (car nums) (car nums) (cons (~a start "->" current) acc)))]))

  (if (empty? nums)
      '()
      (reverse (helper (cdr nums) (car nums) (car nums) '()))))