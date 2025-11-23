(define/contract (group-the-people groupSizes)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let loop ([size->indices (make-hash)]
             [i 0]
             [groupSizes groupSizes]
             [result '()])
    (if (null? groupSizes)
        result
        (let* ([size (car groupSizes)]
               [indices (hash-ref size->indices size '())]
               [new-indices (cons i indices)]
               [new-size->indices (hash-set size->indices size new-indices)])
          (if (= (length new-indices) size)
              (loop (hash-remove new-size->indices size)
                    (+ i 1)
                    (cdr groupSizes)
                    (cons new-indices result))
              (loop new-size->indices
                    (+ i 1)
                    (cdr groupSizes)
                    result))))))