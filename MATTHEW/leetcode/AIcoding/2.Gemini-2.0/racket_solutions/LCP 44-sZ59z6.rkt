(define (build-tree lst)
  (cond [(null? lst) '()]
        [else (list (car lst) (build-tree (cdr lst)))]))

(define (count-distinct-values tree)
  (define (helper tree seen)
    (cond [(null? tree) seen]
          [else (let* ([value (car tree)]
                        [left (cadr tree)])
                    (helper left (set-add seen value))))))
  (set-count (helper tree (set))))

(define (solve lst)
  (count-distinct-values (build-tree lst)))