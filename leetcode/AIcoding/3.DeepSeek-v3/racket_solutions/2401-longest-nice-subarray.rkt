(define/contract (longest-nice-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [mask 0] [max-len 0])
    (if (>= right (length nums))
        max-len
        (let ([num (list-ref nums right)])
          (if (zero? (bitwise-and mask num))
              (loop left (add1 right) (bitwise-ior mask num) (max max-len (add1 (- right left))))
              (loop (add1 left) right (bitwise-and mask (bitwise-not (list-ref nums left))) max-len)))))