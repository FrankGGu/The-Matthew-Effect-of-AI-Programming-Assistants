(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [flips 0] [res 0])
    (if (null? nums)
        res
        (let ([current (if (odd? flips) (- 1 (car nums)) (car nums))])
          (if (= current 1)
              (loop (cdr nums) flips res)
              (loop (cdr nums) (+ flips 1) (+ res 1))))))))