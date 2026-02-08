(define (sum-even-after-queries nums queries)
  (let* ([initial-sum (foldl (lambda (n acc) (if (even? n) (+ n acc) acc)) 0 nums)]
         (result '())
         (process-query
          (lambda (nums initial-sum query)
            (let* ([val (car query)]
                   [index (cadr query)]
                   [original-val (list-ref nums index)]
                   [new-val (+ original-val val)])
              (let* ([new-sum (cond
                                 [(and (even? original-val) (even? new-val)) (+ initial-sum val)]
                                 [(and (even? original-val) (odd? new-val)) (- initial-sum original-val)]
                                 [(and (odd? original-val) (even? new-val)) (+ initial-sum new-val)]
                                 [else initial-sum])])
                (values (list-set nums index new-val) new-sum))))))

    (let loop ([queries queries] [nums nums] [current-sum initial-sum] [acc '()])
      (if (null? queries)
          (reverse acc)
          (let-values ([(new-nums new-sum) (process-query nums current-sum (car queries))])
            (loop (cdr queries) new-nums new-sum (cons new-sum acc)))))))