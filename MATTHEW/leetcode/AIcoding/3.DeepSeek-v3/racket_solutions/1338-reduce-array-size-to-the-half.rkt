(define/contract (min-set-size arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([freq (make-hash)]
         [len (length arr)]
         [half (quotient len 2)]
         [count 0]
         [removed 0])
    (for ([num arr])
      (hash-update! freq num add1 0))
    (let ([sorted-freq (sort (hash->list freq) (lambda (x y) (> (cdr x) (cdr y))))])
      (for ([pair sorted-freq] #:break (>= removed half))
        (set! count (add1 count))
        (set! removed (+ removed (cdr pair)))))
    count))