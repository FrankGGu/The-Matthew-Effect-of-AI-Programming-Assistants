(define/contract (find-least-num-of-unique-ints arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([freq (make-hash)]
         [counts (begin (for ([num arr]) (hash-update! freq num add1 0))
                        (sort (hash-values freq) <))])
    (let loop ([counts counts] [k k] [res (length counts)])
      (cond
        [(null? counts) res]
        [(<= (car counts) k) (loop (cdr counts) (- k (car counts)) (- res 1)]
        [else res]))))