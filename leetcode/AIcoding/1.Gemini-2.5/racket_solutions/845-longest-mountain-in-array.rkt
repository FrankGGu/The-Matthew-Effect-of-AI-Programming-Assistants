(define (longest-mountain-in-array arr)
  (let* ([n (vector-length arr)])
    (if (< n 3)
        0
        (let loop ([i 1]
                   [max-len 0]
                   [up 0]
                   [down 0])
          (if (>= i n)
              max-len
              (let* ([prev (vector-ref arr (- i 1))]
                     [curr (vector-ref arr i)])
                (cond
                  [(= prev curr)
                   (loop (+ i 1) max-len 0 0)]
                  [(< prev curr)
                   (if (> down 0)
                       (loop (+ i 1) max-len 1 0)
                       (loop (+ i 1) max-len (+ up 1) 0))]
                  [(> prev curr)
                   (if (> up 0)
                       (let ([new-down (+ down 1)])
                         (loop (+ i 1) (max max-len (+ up new-down 1)) up new-down))
                       (loop (+ i 1) max-len 0 0))])))))))