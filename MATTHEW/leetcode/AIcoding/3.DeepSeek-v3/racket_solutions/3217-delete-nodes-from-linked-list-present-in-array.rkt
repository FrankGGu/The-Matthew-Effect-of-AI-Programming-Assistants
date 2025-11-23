(define/contract (delete-nodes head to_delete)
  (-> (or/c list? null?) (listof exact-integer?) (or/c list? null?))
  (let ([to_delete_set (list->set to_delete)])
    (let loop ([prev #f] [curr head])
      (cond
        [(null? curr) head]
        [(set-member? to_delete_set (car curr))
         (if prev
             (begin
               (set-cdr! prev (cdr curr))
               (loop prev (cdr curr)))
             (begin
               (set! head (cdr curr))
               (loop #f head)))]
        [else (loop curr (cdr curr))])))
    head)