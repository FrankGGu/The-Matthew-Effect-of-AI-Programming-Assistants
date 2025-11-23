(define/contract (jump nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [jumps 0] [farthest 0] [next-farthest 0])
    (if (= i (length nums))
        jumps
        (loop (+ i 1)
              (if (= i farthest) (+ jumps 1) jumps)
              (max farthest (+ i (list-ref nums i)))
              (max next-farthest (+ i (list-ref nums i)))))))