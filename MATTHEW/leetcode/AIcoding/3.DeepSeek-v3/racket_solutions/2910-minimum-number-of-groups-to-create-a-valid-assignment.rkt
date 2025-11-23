(define/contract (min-groups nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([freq (make-hash)]
         [counts (begin
                  (for ([num nums])
                    (hash-update! freq num add1 0))
                  (hash-values freq))]
         [min-count (apply min counts)]
         [result 0])
    (for ([cnt counts])
      (set! result (+ result (ceiling (/ cnt (+ min-count 1))))))
    result))