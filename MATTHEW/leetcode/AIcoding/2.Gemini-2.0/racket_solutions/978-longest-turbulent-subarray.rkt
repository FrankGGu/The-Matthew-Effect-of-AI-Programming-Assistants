(define (max-turbulent-subarray arr)
  (let ([n (length arr)])
    (if (<= n 1)
        n
        (let loop ([i 1]
                   [up 1]
                   [down 1]
                   [max-len 1])
          (cond
            [(>= i n) max-len]
            [else
             (cond
               [(= (list-ref arr (- i 1)) (list-ref arr i))
                (loop (+ i 1) 1 1 max-len)]
               [(> (list-ref arr (- i 1)) (list-ref arr i))
                (loop (+ i 1) 1 (+ down 1) (max max-len (+ down 1)))]
               [else
                (loop (+ i 1) (+ up 1) 1 (max max-len (+ up 1)))])])))))