(define (smallest-value-rearranged-number num)
  (define digits (string->list (number->string (abs num))))
  (define sorted-digits (sort digits char<?))
  (define (remove-leading-zeros lst)
    (cond
      [(null? lst) '()]
      [(char=? (car lst) #\0) (remove-leading-zeros (cdr lst))]
      [else lst]))

  (define rearranged-digits
    (if (positive? num)
        (let* ([no-leading-zeros (remove-leading-zeros sorted-digits)])
          (if (null? no-leading-zeros)
              (string->number (list->string sorted-digits))
              (let ([first-non-zero (car no-leading-zeros)]
                     [rest (cdr no-leading-zeros)])
                (string->number (list->string (cons first-non-zero (append (make-list (- (length sorted-digits) (length no-leading-zeros)) #\0) rest)))))))
        (reverse sorted-digits)))

  (if (negative? num)
      (- (string->number (list->string rearranged-digits)))
      (string->number (list->string rearranged-digits))))