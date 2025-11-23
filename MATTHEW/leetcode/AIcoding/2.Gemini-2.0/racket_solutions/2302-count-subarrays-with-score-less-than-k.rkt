(define (count-subarrays-with-score-less-than-k nums k)
  (let* ([n (length nums)]
         [count (box 0)])
    (for ([i (in-range n)])
      (let loop ([j i]
                 [current-sum 0])
        (cond
          [(>= j n) (void)]
          [(< (* current-sum (sub1 (+ j 1) i)) k)
           (set-box! count (+ (unbox count) 1))
           (loop (add1 j) (+ current-sum (list-ref nums j)))]
          [else (void)])))
    (unbox count)))