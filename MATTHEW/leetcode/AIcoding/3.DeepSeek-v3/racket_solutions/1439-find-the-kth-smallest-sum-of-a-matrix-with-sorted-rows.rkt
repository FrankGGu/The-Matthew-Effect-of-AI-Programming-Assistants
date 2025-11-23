(define/contract (kth-smallest mat k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let loop ([candidates '(0)]
             [rows mat])
    (if (null? rows)
        (list-ref (sort candidates <) (sub1 k))
        (loop (sort (remove-duplicates (for*/list ([x candidates]
                                                  [y (car rows)])
                    <)
              (cdr rows)))))