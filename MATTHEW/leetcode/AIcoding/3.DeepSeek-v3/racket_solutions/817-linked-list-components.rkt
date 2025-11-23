(define/contract (num-components head g)
  (-> (or/c list? null?) (listof exact-integer?) exact-integer?)
  (let ([g-set (list->set g)]
        [result 0]
        [in-component #f])
    (let loop ([node head])
      (cond
        [(null? node) result]
        [(set-member? g-set (car node))
         (unless in-component
           (set! result (add1 result))
         (set! in-component #t)
         (loop (cdr node))]
        [else
         (set! in-component #f)
         (loop (cdr node))]))))