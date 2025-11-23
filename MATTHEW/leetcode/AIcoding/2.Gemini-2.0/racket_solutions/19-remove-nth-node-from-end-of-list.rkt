(define (remove-nth-from-end list n)
  (define (length lst)
    (if (null? lst)
        0
        (+ 1 (length (cdr lst)))))

  (define len (length list))
  (define (remove-at lst idx cur)
    (cond
      [(null? lst) lst]
      [(= idx cur) (cdr lst)]
      [else (cons (car lst) (remove-at (cdr lst) idx (+ cur 1)))]))

  (if (= n len)
      (cdr list)
      (remove-at list (- len n) 0)))