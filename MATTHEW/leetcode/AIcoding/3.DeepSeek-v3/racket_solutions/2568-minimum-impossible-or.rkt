(define/contract (minimum-impossible-or nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([mask 1])
    (if (not (member mask nums))
        mask
        (loop (arithmetic-shift mask 1)))))