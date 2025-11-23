(define/contract (missing-integer nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 1] [seen (set)])
    (if (set-member? seen i)
        (loop (+ i 1) seen)
        (if (not (index-of nums i))
            i
            (loop (+ i 1) (set-add seen i))))))