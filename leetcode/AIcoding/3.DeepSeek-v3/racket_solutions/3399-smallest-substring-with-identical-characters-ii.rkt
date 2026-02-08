(define/contract (smallest-substring s)
  (-> string? string?)
  (let loop ([i 0] [j 0] [min-len (add1 (string-length s))] [result ""])
    (cond
      [(>= j (string-length s)) result]
      [(= (string-ref s i) (string-ref s j))
       (let ([current-len (- j i -1)])
       (if (< current-len min-len)
           (loop i (add1 j) current-len (substring s i (+ j 1)))
           (loop i (add1 j) min-len result))]
      [else (loop (add1 j) (add1 j) min-len result)])))