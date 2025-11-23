(define (sort-and-concat s)
  (let* ([chars (string->list s)]
         [sorted-chars (sort chars char<?)])
    (list->string sorted-chars)))

(define (increasing-decreasing-string s)
  (let loop ([chars (string->list s)]
             [result '()])
    (if (null? chars)
        (list->string (reverse result))
        (let* ([sorted-chars (sort chars char<?)]
               [increasing-part (cons (car sorted-chars)
                                       (filter (lambda (c) (char>? c (car sorted-chars)))
                                               (cdr sorted-chars)))]
               [remaining-chars (filter (lambda (c) (not (member c increasing-part)))
                                        chars)]
               [sorted-remaining-chars (sort remaining-chars char>?)])
          (if (null? increasing-part)
              (list->string (reverse result))
              (let* ([decreasing-part (cons (car sorted-remaining-chars)
                                           (filter (lambda (c) (char<? c (car sorted-remaining-chars)))
                                                   (cdr sorted-remaining-chars)))]
                     [next-remaining-chars (filter (lambda (c) (not (member c decreasing-part)))
                                                     remaining-chars)])
                (if (null? decreasing-part)
                    (list->string (reverse (append result increasing-part)))
                    (loop next-remaining-chars (append decreasing-part increasing-part result)))))))))