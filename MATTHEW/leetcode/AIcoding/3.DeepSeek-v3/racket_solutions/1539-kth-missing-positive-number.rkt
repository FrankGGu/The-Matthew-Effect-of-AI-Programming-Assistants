(define/contract (find-kth-positive arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 1]
             [missing 0]
             [index 0])
    (cond
      [(= missing k) (- i 1)]
      [(and (< index (length arr)) (= i (list-ref arr index)))
       (loop (+ i 1) missing (+ index 1))]
      [else
       (loop (+ i 1) (+ missing 1) index)])))