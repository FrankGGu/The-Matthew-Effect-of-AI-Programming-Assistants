(define (checkBalancedString s)
  (define count (make-hash '()))
  (for-each (lambda (c)
              (hash-set! count c (+ (hash-ref count c 0) 1)))
            (string->list s))
  (equal? (hash-ref count #\L 0) (hash-ref count #\R 0)))

(checkBalancedString "LDRRLRLLRLL") ; Example call