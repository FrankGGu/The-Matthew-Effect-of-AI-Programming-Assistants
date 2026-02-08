(define/contract (pivot-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (apply + nums)] [i 0])
    (cond
      [(= i (length nums)) -1]
      [(= left (- right (list-ref nums i))) i]
      [else (loop (+ left (list-ref nums i)) (- right (list-ref nums i)) (+ i 1))])))