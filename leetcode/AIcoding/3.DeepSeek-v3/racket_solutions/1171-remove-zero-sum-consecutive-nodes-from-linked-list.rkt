(define/contract (remove-zero-sum-sublists head)
  (-> (or/c list? null?) (or/c list? null?))
  (let loop ([current head] [sum 0] [sums (make-hash '((0 . #f)))] [dummy (cons 0 #f)] [prev dummy])
    (if (null? current)
        (let-values ([(sum sums) (values 0 (make-hash '((0 . #f))))])
          (let loop ([current (cdr dummy)])
            (if (null? current)
                (cdr dummy)
                (let* ([sum (+ sum (car current))]
                       [node (hash-ref sums sum)])
                  (hash-set! sums sum current)
                  (set-cdr! node (cdr current))
                  (loop (cdr current))))))
        (let* ([sum (+ sum (car current))]
               [node (hash-ref sums sum #f)])
          (if node
              (begin
                (set-cdr! node (cdr current))
                (loop (cdr current) sum sums dummy node))
              (begin
                (hash-set! sums sum current)
                (set-cdr! prev current)
                (loop (cdr current) sum sums dummy current)))))))