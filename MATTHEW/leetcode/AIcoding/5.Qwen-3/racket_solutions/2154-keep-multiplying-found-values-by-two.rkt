(define/contract (find-equal-index-and-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [nums nums])
    (if (>= i (length nums))
        -1
        (if (= i (list-ref nums i))
            i
            (loop (+ i 1) nums)))))