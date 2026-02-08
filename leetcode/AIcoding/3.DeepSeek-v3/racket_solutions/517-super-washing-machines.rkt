(define/contract (find-min-moves machines)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([total (apply + machines)]
         [n (length machines)]
         [avg (quotient total n)])
    (if (not (zero? (remainder total n)))
        -1
        (let loop ([i 0]
                   [sum 0]
                   [res 0])
          (if (= i n)
              res
              (let* ([num (list-ref machines i)]
                     [diff (- num avg)]
                     [new-sum (+ sum diff)]
                     [new-res (max res (abs new-sum) diff)])
                (loop (add1 i) new-sum new-res)))))))