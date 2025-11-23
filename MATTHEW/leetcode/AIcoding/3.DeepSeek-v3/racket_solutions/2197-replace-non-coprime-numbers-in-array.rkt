(define/contract (replace-non-coprimes nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (gcd a b)
    (if (zero? b) a (gcd b (modulo a b))))
  (let loop ([stack '()] [nums nums])
    (if (null? nums)
        (reverse stack)
        (let* ([current (car nums)]
               [rest-nums (cdr nums)]
               [new-stack (cons current stack)])
          (let inner ([stack new-stack])
            (if (< (length stack) 2)
                (loop stack rest-nums)
                (let* ([a (car stack)]
                       [b (cadr stack)]
                       [g (gcd a b)])
                  (if (= g 1)
                      (loop stack rest-nums)
                      (inner (cons (quotient (* a b) g) (cddr stack)))))))))))