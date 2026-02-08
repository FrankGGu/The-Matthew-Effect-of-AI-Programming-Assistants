(define (level-order-bottom root)
  (define (helper node level result)
    (if (null? node)
        result
        (begin
          (if (not (list? (list-ref result level (list))))
              (set! result (append result (list (list (car node)))))
              (set! result (list-update result level (lambda (x) (append x (list (car node)))))))
          (set! result (helper (cadr node) (+ level 1) result))
          (set! result (helper (caddr node) (+ level 1) result))
          result)))

  (let ([result (helper root 0 '())])
    (reverse (map (lambda (x) x) result))))