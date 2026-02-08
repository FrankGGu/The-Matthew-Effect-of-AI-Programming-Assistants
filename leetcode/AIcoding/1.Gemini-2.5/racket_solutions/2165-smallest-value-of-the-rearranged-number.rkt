(define (smallest-value-of-rearranged-number num)
  (cond
    ((= num 0) 0)
    ((> num 0)
     (let* ((s (number->string num))
            (chars (string->list s))
            (zero-count (count (lambda (c) (char=? c #\0)) chars))
            (non-zero-chars (sort (filter (lambda (c) (not (char=? c #\0))) chars) char<?)))
       ;; non-zero-chars will not be empty for num > 0
       (let* ((first-non-zero (car non-zero-chars))
              (rest-non-zero (cdr non-zero-chars))
              (zeros (make-list zero-count #\0))
              (final-chars (append (list first-non-zero) zeros rest-non-zero)))
         (string->number (list->string final-chars)))))
    (else ; num < 0
     (let* ((abs-num (- num))
            (s (number->string abs-num))
            (chars (string->list s))
            (sorted-chars (sort chars char>?))) ; Sort descending for largest absolute value
       (- (string->number (list->string sorted-chars)))))))