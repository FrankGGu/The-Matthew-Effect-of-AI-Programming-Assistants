(define/contract (maximum-distinct-elements nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([freq (make-hash)]
         [count (for/sum ([num nums])
                  (hash-update! freq num add1 0)
                  1)]
         [duplicates (for/sum ([(key val) (in-hash freq)]
                       (if (> val 1) 1 0))]
         [distinct (hash-count freq)])
    (if (<= k duplicates)
        distinct
        (- distinct (- k duplicates)))))