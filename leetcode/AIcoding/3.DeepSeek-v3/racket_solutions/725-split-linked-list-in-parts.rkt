(define/contract (split-list-to-parts root k)
  (-> (or/c list? null?) exact-integer? (listof (or/c list? null?)))
  (let* ([len (let loop ([node root] [n 0])
                (if (null? node) n (loop (cdr node) (add1 n)))]
         [part-size (quotient len k)]
         [extra (remainder len k)]
         [sizes (for/list ([i (in-range k)])
                  (if (< i extra) (add1 part-size) part-size))])
    (let loop ([node root] [sizes sizes])
      (if (null? sizes)
          '()
          (let-values ([(head tail) (split-at node (car sizes))])
            (cons head (loop tail (cdr sizes)))))))