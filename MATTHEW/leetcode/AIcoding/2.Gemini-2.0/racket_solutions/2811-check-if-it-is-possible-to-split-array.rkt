(define (canSplitArray nums m)
  (cond
    [(null? nums) #t]
    [(<= (length nums) 1) #t]
    [else
     (let loop ([xs (cdr nums)]
                [prev (car nums)])
       (cond
         [(null? xs) #t]
         [(>= (+ prev (car xs)) m) #t]
         [else (loop (cdr xs) (+ prev (car xs)))])
       )]))