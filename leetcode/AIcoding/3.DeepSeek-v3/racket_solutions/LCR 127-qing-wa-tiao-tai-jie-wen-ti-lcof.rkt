(define/contract (jump nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([pos 0]
             [max-reach 0]
             [steps 0]
             [end 0])
    (if (>= end (sub1 (length nums)))
        steps
        (loop (add1 pos)
              (max max-reach (+ pos (list-ref nums pos)))
              (if (> pos end) (add1 steps) steps)
              (if (> pos end) max-reach end)))))