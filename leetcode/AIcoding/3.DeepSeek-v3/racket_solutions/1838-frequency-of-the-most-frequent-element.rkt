(define/contract (max-frequency nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [left 0]
         [right 0]
         [total 0]
         [max-freq 0])
    (for ([right (in-range n)])
    (let loop ([left 0] [right 0] [total 0] [max-freq 0])
      (if (>= right n)
          max-freq
          (let* ([current (list-ref sorted-nums right)]
                 [total (+ total current)]
                 [window-size (+ (- right left) 1)]
                 [needed (* current window-size)])
            (if (<= (- needed total) k)
                (begin
                  (set! max-freq (max max-freq window-size))
                  (loop left (+ right 1) total max-freq))
                (begin
                  (loop (+ left 1) right (- total (list-ref sorted-nums left)) max-freq))))))))