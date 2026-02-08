(define/contract (count-elements nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([min-val (apply min nums)]
         [max-val (apply max nums)]
         [count 0])
    (for ([num nums])
      (when (and (> num min-val) (< num max-val))
        (set! count (add1 count)))
    count))