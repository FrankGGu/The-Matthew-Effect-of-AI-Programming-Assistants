(define/contract (jump nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([pos 0] [max-reach 0] [steps 0] [end 0])
    (if (>= pos (sub1 (length nums)))
        steps
        (let ([new-max-reach (max max-reach (+ pos (list-ref nums pos)))])
          (if (>= pos end)
              (loop (add1 pos) new-max-reach (add1 steps) new-max-reach)
              (loop (add1 pos) new-max-reach steps end)))))