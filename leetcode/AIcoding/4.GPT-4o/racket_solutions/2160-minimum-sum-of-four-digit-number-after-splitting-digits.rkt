(define (minimumSum num)
  (let* ((digits (map (lambda (x) (string->number (string x))) (string->list (number->string num))))
         (sorted-digits (sort digits <))
         (num1 (+ (* 10 (list-ref sorted-digits 0)) (list-ref sorted-digits 2)))
         (num2 (+ (* 10 (list-ref sorted-digits 1)) (list-ref sorted-digits 3))))
    (+ num1 num2)))

(minimumSum 2932) ; Example function call