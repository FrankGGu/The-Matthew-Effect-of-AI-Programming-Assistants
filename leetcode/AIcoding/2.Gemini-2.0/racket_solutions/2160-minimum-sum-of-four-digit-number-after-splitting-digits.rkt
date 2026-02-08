(define (minimum-sum num)
  (let* ([digits (sort (string->list (number->string num)) char<?)]
         [num1 (string->number (list->string (list (car digits) (caddr digits))))]
         [num2 (string->number (list->string (list (cadr digits) (cadddr digits))))])
    (+ num1 num2)))