(define (add-binary a b)
  (let loop ([a (string->list a)]
             [b (string->list b)]
             [carry 0]
             [result '()])
    (cond
      [(and (empty? a) (empty? b) (= carry 0))
       (list->string (reverse result))]
      [else
       (let ([digit-a (if (empty? a) 0 (string->number (list->string (list (last a)))))]
             [digit-b (if (empty? b) 0 (string->number (list->string (list (last b)))))]
             [sum (+ digit-a digit-b carry)])
         (loop (if (empty? a) a (drop-right a 1))
               (if (empty? b) b (drop-right b 1))
               (quotient sum 2)
               (cons (number->string (remainder sum 2)) result)))))))