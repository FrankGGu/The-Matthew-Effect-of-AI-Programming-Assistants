(define/contract (min-operations nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)] [target target] [ops 0])
    (cond
      [(= target 0) ops]
      [(null? nums) -1]
      [else
       (let* ([num (car nums)]
              [rest (cdr nums)]
              [sum (apply + nums)])
         (cond
           [(> num target) (loop rest target ops)]
           [(<= sum target) (if (= sum target) (+ ops (length nums)) -1)]
           [else
            (let ([new-num (quotient num 2)])
              (if (zero? new-num)
                  -1
                  (loop (sort (cons new-num (cons new-num rest)) <) target (add1 ops))))]))])))