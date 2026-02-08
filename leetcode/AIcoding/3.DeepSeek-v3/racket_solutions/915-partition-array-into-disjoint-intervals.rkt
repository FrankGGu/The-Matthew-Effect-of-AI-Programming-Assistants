(define/contract (partition-disjoint nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left-max (car nums)]
             [current-max (car nums)]
             [partition 1]
             [i 1]
             [n (length nums)])
    (if (= i n)
        partition
        (let ([num (list-ref nums i)]
              [new-current-max (max current-max (list-ref nums i))])
          (if (< num left-max)
              (loop new-current-max new-current-max (+ i 1) (+ i 1) n)
              (loop left-max new-current-max partition (+ i 1) n))))))