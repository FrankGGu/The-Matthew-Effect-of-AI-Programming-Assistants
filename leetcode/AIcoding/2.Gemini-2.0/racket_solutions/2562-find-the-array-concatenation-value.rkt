(define (find-the-array-concVal nums)
  (let loop ([nums nums] [acc 0])
    (cond
      [(empty? nums) acc]
      [(empty? (cdr nums)) (+ acc (car nums))]
      [else
       (let ([first (car nums)]
             [last (car (reverse nums))])
         (loop (cdr (drop-right nums 1))
               (+ acc (string->number (string-append (number->string first) (number->string last))))))])))