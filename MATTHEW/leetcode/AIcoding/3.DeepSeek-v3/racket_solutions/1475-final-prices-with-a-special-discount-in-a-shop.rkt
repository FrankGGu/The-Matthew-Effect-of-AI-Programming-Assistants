(define/contract (final-prices prices)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (helper lst)
    (cond
      [(null? lst) '()]
      [else
       (let ([first-item (car lst)]
             [rest-items (cdr lst)])
         (let loop ([items rest-items])
           (cond
             [(null? items) (cons first-item (helper rest-items))]
             [(<= (car items) first-item) 
              (cons (- first-item (car items)) (helper rest-items))]
             [else (loop (cdr items))])))]))
  (helper prices))