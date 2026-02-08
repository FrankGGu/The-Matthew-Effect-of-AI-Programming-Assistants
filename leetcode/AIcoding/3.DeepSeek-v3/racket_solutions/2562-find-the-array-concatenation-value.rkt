(define/contract (find-array-concatenation-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [sum 0])
    (cond
      [(null? nums) sum]
      [(null? (cdr nums)) (+ sum (car nums))]
      [else
       (let* ([first (car nums)]
              [last (last nums)]
              [rest (drop-right (cdr nums) 1)]
              [concatenated (string->number (string-append (number->string first) (number->string last)))])
         (loop rest (+ sum concatenated)))])))