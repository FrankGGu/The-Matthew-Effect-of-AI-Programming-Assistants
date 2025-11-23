(define/contract (prefixes-div-by5 nums)
  (-> (listof exact-integer?) (listof boolean?))
  (let loop ([nums nums] [acc 0] [res '()])
    (if (null? nums)
        (reverse res)
        (let* ([num (car nums)]
               [new-acc (modulo (+ (* acc 2) num) 5)]
               [divisible? (zero? new-acc)])
          (loop (cdr nums) new-acc (cons divisible? res))))))