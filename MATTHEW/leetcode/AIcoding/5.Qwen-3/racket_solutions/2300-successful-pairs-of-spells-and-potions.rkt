(define/contract (successful-pairs spells potions success)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length potions)]
         [sorted-potions (sort potions <)])
    (for/list ([s spells])
      (let loop ([l 0] [r (- n 1)] [count 0])
        (if (> l r)
            count
            (let ([mid (quotient (+ l r) 2)])
              (if (<= (* s (list-ref sorted-potions mid)) success)
                  (loop (add1 mid) r (+ count (- r mid 1)))
                  (loop l (sub1 mid) count))))))))