(define/contract (check-possibility nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([nums nums] [modified #f] [prev -inf.0])
    (cond
      [(null? nums) #t]
      [(<= (car nums) prev)
       (if modified
           #f
           (or (loop (cdr nums) #t prev)
                (and (not (null? (cdr nums)))
                     (<= (car nums) (cadr nums))
                     (loop (cdr nums) #t (car nums)))))]
      [else (loop (cdr nums) modified (car nums))])))