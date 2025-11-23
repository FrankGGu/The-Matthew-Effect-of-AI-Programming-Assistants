(define (add-to-array-form num k)
  ;; Converts a list of digits (array-form) to an integer.
  ;; Example: '(1 2 3) -> 123
  (define (list->int lst)
    (foldl (lambda (digit acc)
             (+ (* acc 10) digit))
           0
           lst))

  ;; Converts an integer to a list of its digits (array-form).
  ;; Example: 123 -> '(1 2 3)
  (define (int->list-of-digits n)
    (if (= n 0)
        '(0)
        (let loop ((current-n n)
                   (digits '()))
          (if (= current-n 0)
              digits
              (loop (quotient current-n 10)
                    (cons (remainder current-n 10) digits))))))

  ;; Calculate the sum of the number represented by 'num' and 'k'
  (let ((total-sum (+ (list->int num) k)))
    ;; Convert the sum back to array-form (list of digits)
    (int->list-of-digits total-sum)))