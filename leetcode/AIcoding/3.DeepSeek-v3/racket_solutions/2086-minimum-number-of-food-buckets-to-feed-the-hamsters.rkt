(define/contract (minimum-buckets street)
  (-> string? exact-integer?)
  (let loop ([i 0] [buckets 0] [n (string-length street)])
    (cond
      [(>= i n) buckets]
      [(char=? (string-ref street i) #\H)
       (cond
         [(and (> i 0) (char=? (string-ref street (- i 1)) #\B)) (loop (+ i 1) buckets n)]
         [(and (< i (- n 1)) (char=? (string-ref street (+ i 1)) #\.))
          (string-set! street (+ i 1) #\B)
          (loop (+ i 2) (+ buckets 1) n)]
         [(and (> i 0) (char=? (string-ref street (- i 1)) #\.))
          (string-set! street (- i 1) #\B)
          (loop (+ i 1) (+ buckets 1) n)]
         [else -1])]
      [else (loop (+ i 1) buckets n)])))