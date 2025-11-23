(define (max-operations nums)
  (let* ([first-val (car nums)]
         [second-val (cadr nums)]
         [target-score (+ first-val second-val)])
    (let loop ([current-list (cddr nums)] [count 1])
      (if (or (null? current-list) (null? (cdr current-list)))
          count
          (let* ([val1 (car current-list)]
                 [val2 (cadr current-list)])
            (if (= (+ val1 val2) target-score)
                (loop (cddr current-list) (+ count 1))
                (loop (cddr current-list) count)))))))