(define (sort-jumbled-numbers mapping nums)
  (define (transform n)
    (string->number
     (list->string
      (map (lambda (c)
             (integer->char (+ (list-ref mapping (- (char->integer c) (char->integer #\0))) (char->integer #\0))))
           (string->list (number->string n))))))
  (sort nums (lambda (a b) (< (transform a) (transform b)))))