(define/contract (reduction-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums <)]
         [freq (make-hash)]
         [unique-sorted (remove-duplicates sorted)])
    (for ([num sorted])
      (hash-update! freq num add1 0))
    (let loop ([remaining unique-sorted] [res 0] [prev-count 0])
      (if (null? remaining)
          res
          (let* ([current (car remaining)]
                 [count (hash-ref freq current)]
                 [new-res (+ res prev-count)]
                 [new-prev-count (+ prev-count count)])
            (loop (cdr remaining) new-res new-prev-count))))))