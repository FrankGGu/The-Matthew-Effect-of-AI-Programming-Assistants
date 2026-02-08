(define/contract (find-length-of-shortest-subarray arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length arr)]
         [left 0]
         [right (- n 1)])
    (let loop-left ([i 0])
      (if (or (>= i (- n 1)) (> (list-ref arr i) (list-ref arr (+ i 1))))
          (set! left i)
          (loop-left (+ i 1))))
    (if (= left (- n 1)) 0
        (let loop-right ([j (- n 1)])
          (if (or (<= j 0) (< (list-ref arr (- j 1)) (list-ref arr j)))
              (set! right j)
              (loop-right (- j 1))))
        (let ([res (min right (- n left 1))])
          (let ([i 0] [j right])
            (let loop ([i i] [j j])
              (if (and (<= i left) (< j n))
                  (if (<= (list-ref arr i) (list-ref arr j))
                      (begin
                        (set! res (min res (- j i 1)))
                        (loop (+ i 1) j))
                      (loop i (+ j 1)))
                  res)))))))