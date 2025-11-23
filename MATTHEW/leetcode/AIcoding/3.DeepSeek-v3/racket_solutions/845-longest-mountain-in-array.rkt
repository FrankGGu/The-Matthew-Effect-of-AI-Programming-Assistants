(define/contract (longest-mountain arr)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length arr))
  (if (< n 3)
      0
      (let loop ([i 1] [max-len 0])
        (if (>= i (- n 1))
            max-len
            (if (and (> (list-ref arr i) (list-ref arr (- i 1)))
                     (> (list-ref arr i) (list-ref arr (+ i 1))))
                (let ([left (let left-loop ([j (- i 1)] [len 1])
                              (if (or (< j 0) (<= (list-ref arr j) (list-ref arr (+ j 1))))
                                  len
                                  (left-loop (- j 1) (+ len 1))))]
                      [right (let right-loop ([j (+ i 1)] [len 1])
                               (if (or (>= j n) (<= (list-ref arr j) (list-ref arr (- j 1))))
                                   len
                                   (right-loop (+ j 1) (+ len 1))))])
                  (loop (+ i 1) (max max-len (+ left right 1))))
                (loop (+ i 1) max-len))))))