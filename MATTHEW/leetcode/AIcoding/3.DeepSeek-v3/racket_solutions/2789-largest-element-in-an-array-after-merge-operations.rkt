(define/contract (max-array-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [max-val 0])
    (cond
      [(null? nums) max-val]
      [(null? (cdr nums)) (max max-val (car nums))]
      [else
       (let* ([a (car nums)]
              [b (cadr nums)]
              [new-nums (if (<= a b)
                            (cons (+ a b) (cddr nums))
                            (cdr nums))])
         (loop new-nums (max max-val a)))])))