(define/contract (smallest-number num)
  (-> exact-integer? exact-integer?)
  (let* ([digits (string->list (number->string num))]
         [negative? (char=? (car digits) #\-)]
         [digits (if negative? (cdr digits) digits)]
         [sorted (sort digitis char<?)])
    (cond
      [negative?
       (string->number (list->string (cons #\- (reverse sorted))))]
      [else
       (let loop ([digits sorted])
         (cond
           [(null? digits) 0]
           [(char=? (car digits) #\0)
            (loop (cdr digits))]
           [else
            (string->number
             (list->string
              (cons (car digits)
                    (append (make-list (length (filter (lambda (c) (char=? c #\0)) (cdr digits))) #\0)
                            (filter (lambda (c) (not (char=? c #\0))) (cdr digits))))))]))])))