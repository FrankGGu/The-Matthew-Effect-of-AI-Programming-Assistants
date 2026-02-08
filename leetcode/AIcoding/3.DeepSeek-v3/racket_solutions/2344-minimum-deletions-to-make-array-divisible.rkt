(define/contract (min-operations nums numsDivide)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (gcd-list lst)
    (if (null? lst)
        0
        (foldl gcd (car lst) (cdr lst))))
  (let* ([g (gcd-list numsDivide)]
         [sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [result (for/first ([i (in-range n)]
                            #:when (zero? (modulo g (list-ref sorted-nums i))))
                   i)])
    (if result result -1)))