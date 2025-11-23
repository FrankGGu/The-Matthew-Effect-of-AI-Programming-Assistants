(define (find-prefix-score nums)
  (let loop ([nums nums]
             [max-so-far (car nums)]
             [prefix-sum 0]
             [result '()])
    (if (null? nums)
        (reverse result)
        (let* ([current-num (car nums)]
               [new-max (max max-so-far current-num)]
               [score (+ current-num new-max)]
               [new-prefix-sum (+ prefix-sum score)])
          (loop (cdr nums)
                new-max
                new-prefix-sum
                (cons new-prefix-sum result))))))