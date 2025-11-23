(define/contract (sum-even-after-queries nums queries)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) (listof exact-integer?))
  (let loop ([nums nums]
             [queries queries]
             [sum-even (apply + (filter even? nums))]
             [result '()])
    (if (null? queries)
        (reverse result)
        (let* ([query (car queries)]
               [val (car query)]
               [index (cadr query)]
               [old-num (list-ref nums index)]
               [new-num (+ old-num val)]
               [new-nums (list-set nums index new-num)]
               [new-sum-even (cond [(and (even? old-num) (even? new-num)) (+ sum-even (- new-num old-num))]
                                  [(and (even? old-num) (not (even? new-num))) (- sum-even old-num)]
                                  [(and (not (even? old-num)) (even? new-num)) (+ sum-even new-num)]
                                  [else sum-even])])
          (loop new-nums
                (cdr queries)
                new-sum-even
                (cons new-sum-even result))))))