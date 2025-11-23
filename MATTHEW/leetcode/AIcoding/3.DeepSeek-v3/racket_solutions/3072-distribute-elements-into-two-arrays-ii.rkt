(define (distribute-elements nums)
  (let loop ([nums nums]
             [arr1 '()]
             [arr2 '()]
             [rev-arr1 '()]
             [rev-arr2 '()])
    (if (null? nums)
        (append (reverse arr1) (reverse arr2))
        (let* ([current (car nums)]
               [rest-nums (cdr nums)]
               [count-greater-arr1 (count (lambda (x) (> x current)) rev-arr1)]
               [count-greater-arr2 (count (lambda (x) (> x current)) rev-arr2)])
          (if (or (> count-greater-arr1 count-greater-arr2)
                  (and (= count-greater-arr1 count-greater-arr2)
                       (<= (length arr1) (length arr2))))
              (loop rest-nums
                    (cons current arr1)
                    arr2
                    (cons current rev-arr1)
                    rev-arr2)
              (loop rest-nums
                    arr1
                    (cons current arr2)
                    rev-arr1
                    (cons current rev-arr2)))))))