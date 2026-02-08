(define (count-subarrays-with-score-less-than-k nums k)
  (let* ([n (length nums)]
         [arr (list->vector nums)])
    (let loop ([left 0]
               [right 0]
               [current-sum 0]
               [count 0])
      (if (>= right n)
          count
          (let* ([num-at-right (vector-ref arr right)]
                 [new-sum (+ current-sum num-at-right)])
            (let inner-loop ([l left]
                             [s new-sum])
              (let* ([len (- right l -1)] ; length of window [l...right]
                     [score (* s len)])
                (if (and (> len 0) (>= score k))
                    (let* ([num-at-left (vector-ref arr l)]
                           [shrunk-sum (- s num-at-left)])
                      (inner-loop (+ l 1) shrunk-sum))
                    (loop l (+ right 1) s (+ count len))))))))))