(define/contract (min-pair-removal nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [stack '()] [removed 0])
    (if (null? nums)
        removed
        (let* ([current (car nums)]
               [rest-nums (cdr nums)]
               [new-stack (if (null? stack) (list current) stack)]
               [top (car new-stack)])
          (cond
            [(<= current top) (loop rest-nums (cons current new-stack) removed)]
            [else (loop rest-nums new-stack (add1 removed))])))))