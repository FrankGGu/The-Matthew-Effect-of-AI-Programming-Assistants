(define (moving-stones-until-consecutive-ii stones)
  (let* ([n (length stones)]
         [sorted-stones (sort stones <)])
    (if (<= n 2)
        (list 0 0)
        (let* ([s0 (list-ref sorted-stones 0)]
               [s_n-1 (list-ref sorted-stones (- n 1))]
               [s1 (list-ref sorted-stones 1)]
               [s_n-2 (list-ref sorted-stones (- n 2))])
          (let ([max-moves (- (max (- s_n-1 s1) (- s_n-2 s0)) (- n 2))])
            (let loop ([i 0] [j 0] [max-stones-in-window 0])
              (if (= j n)
                  (let ([min-res (- n max-stones-in-window)])
                    (if (and (= max-stones-in-window (- n 1))
                             (= (+ (- s_n-1 s0) 1) (+ n 2)))
                        (list 2 max-moves)
                        (list min-res max-moves)))
                  (let* ([current-s-j (list-ref sorted-stones j)]
                         [current-s-i (list-ref sorted-stones i)])
                    (if (> (- current-s-j current-s-i -1) n)
                        (loop (+ i 1) j max-stones-in-window)
                        (loop i (+ j 1) (max max-stones-in-window (- j i -1)))))))))))