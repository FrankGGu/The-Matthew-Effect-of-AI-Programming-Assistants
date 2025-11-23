(define/contract (latest-time-to-catch-bus buses passengers capacity)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-buses (sort buses <)]
         [sorted-passengers (sort passengers <)]
         [n (length sorted-buses)]
         [m (length sorted-passengers)]
         [i 0]
         [j 0]
         [result 0])
    (while (and (< i n) (< j m))
      (let ([bus sorted-buses[i]]
            [cap capacity]
            [last-passenger 0])
        (while (and (< j m) (< sorted-passengers[j] bus) (> cap 0))
          (set! last-passenger sorted-passengers[j])
          (set! j (+ j 1))
          (set! cap (- cap 1))
        (if (> cap 0)
            (set! result bus)
            (set! result (- last-passenger 1)))
        (set! i (+ i 1))))
    (let ([k (- j 1)])
      (while (and (>= k 0) (equal? result sorted-passengers[k]))
        (set! result (- result 1))
        (set! k (- k 1)))
    result))