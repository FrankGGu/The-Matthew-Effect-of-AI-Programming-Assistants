(define/contract (top-k-frequent nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([freq (make-hash)]
         [counts (for/fold ([acc freq]) ([num nums])
                   (hash-update acc num add1 0)
                   acc)]
         [sorted (sort (hash->list counts)
                       (lambda (a b) (> (cdr a) (cdr b))))])
    (take (map car sorted) k)))