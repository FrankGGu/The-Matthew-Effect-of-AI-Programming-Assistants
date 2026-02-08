(define (minimum-number-game nums)
  (cond
    [(empty? nums) '()]
    [else
     (let* ([a (car nums)]
            [b (cadr nums)]
            [rest (cddr nums)]
            [min-a-b (min a b)]
            [max-a-b (max a b)])
       (cons max-a-b (cons min-a-b (minimum-number-game rest)))))])