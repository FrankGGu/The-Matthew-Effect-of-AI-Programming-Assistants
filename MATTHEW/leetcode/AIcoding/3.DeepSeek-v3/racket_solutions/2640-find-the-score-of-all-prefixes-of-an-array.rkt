(define/contract (find-prefix-score nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums]
             [max-so-far -inf.0]
             [sum 0]
             [res '()])
    (if (null? nums)
        (reverse res)
        (let* ([current (car nums)]
               [new-max (max max-so-far current)]
               [new-sum (+ sum new-max current)]
               [new-res (cons new-sum res)])
          (loop (cdr nums) new-max new-sum new-res)))))