(define/contract (minimum-added-coins coins target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([coins (sort coins <)]
             [current 1]
             [added 0]
             [i 0]
             [n (length coins)])
    (cond
      [(> current target) added]
      [(and (< i n) (<= (list-ref coins i) current))
       (loop coins
             (+ current (list-ref coins i))
             added
             (+ i 1)
             n)]
      [else
       (loop coins
             (+ current current)
             (+ added 1)
             i
             n)])))