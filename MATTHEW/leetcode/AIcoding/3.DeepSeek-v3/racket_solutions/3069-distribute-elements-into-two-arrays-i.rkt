(define/contract (distribute-elements nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums]
             [arr1 '()]
             [arr2 '()])
    (if (null? nums)
        (append (reverse arr1) (reverse arr2))
        (let ([current (car nums)]
              [rest (cdr nums)])
          (if (or (null? arr1)
                  (> current (last arr1)))
              (loop rest (cons current arr1) arr2)
              (loop rest arr1 (cons current arr2))))))