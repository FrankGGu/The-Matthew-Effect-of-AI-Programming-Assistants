(define/contract (permute-unique nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (define (insert-pos x lst)
    (for/list ([i (in-range (add1 (length lst)))])
      (append (take lst i) (list x) (drop lst i))))

  (define (permute lst)
    (if (null? lst)
        '(())
        (remove-duplicates
         (apply append
                (for/list ([p (permute (cdr lst))])
                  (insert-pos (car lst) p))))))

  (permute nums))