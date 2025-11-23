(define/contract (find-max-average nums k)
  (-> (listof exact-integer?) exact-integer? flonum?)
  (let loop ([sum (apply + (take nums k))]
             [max-sum sum]
             [i k]
             [n (length nums)])
    (if (>= i n)
        (/ max-sum k)
        (let* ([new-sum (- sum (list-ref nums (- i k)) (list-ref nums i))]
               [new-max (max max-sum new-sum)])
          (loop new-sum new-max (add1 i) n)))))