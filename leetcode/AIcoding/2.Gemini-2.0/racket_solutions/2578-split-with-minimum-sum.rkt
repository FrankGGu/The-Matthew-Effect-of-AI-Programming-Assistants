(define (split-num num)
  (let loop ([digits (sort (string->list (number->string num)) char<?)]
             [num1 ""]
             [num2 ""]
             [turn #t])
    (cond
      [(empty? digits)
       (values (string->number num1) (string->number num2))]
      [else
       (if turn
           (loop (rest digits) (string-append num1 (list->string (list (first digits)))) num2 #f)
           (loop (rest digits) num1 (string-append num2 (list->string (list (first digits)))) #t))])))

(define (minimum-sum num)
  (let-values ([(num1 num2) (split-num num)])
    (+ num1 num2)))