(define (total-steps nums)
  (let loop ([stack '()] [steps 0])
    (cond
      [(empty? nums) steps]
      [else
       (let* ([curr (car nums)]
              [new-stack
               (let loop2 ([s stack] [curr curr] [c 0])
                 (cond
                   [(empty? s) (cons (cons curr c) '())]
                   [(<= (car (car s)) curr) (cons (cons curr c) s)]
                   [else (loop2 (cdr s) curr (+ c (cdr (car s))))]))])
         (loop (cons (car new-stack) (cdr new-stack)) (max steps (cdr (car new-stack))) (cdr nums)))])))