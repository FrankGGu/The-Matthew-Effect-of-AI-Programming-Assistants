(define/contract (get-descent-periods prices)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 1] [n (length prices)] [current 1] [total 1])
    (if (>= i n)
        total
        (if (= (- (list-ref prices (- i 1)) (list-ref prices i)) 1)
            (loop (+ i 1) n (+ current 1) (+ total current 1))
            (loop (+ i 1) n 1 (+ total 1))))))