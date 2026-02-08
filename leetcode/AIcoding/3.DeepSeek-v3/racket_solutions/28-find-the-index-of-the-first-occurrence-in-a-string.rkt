(define/contract (str-str haystack needle)
  (-> string? string? exact-integer?)
  (define h-len (string-length haystack))
  (define n-len (string-length needle))
  (cond
    [(= n-len 0) 0]
    [(< h-len n-len) -1]
    [else
     (let loop ([i 0])
       (cond
         [(> i (- h-len n-len)) -1]
         [(string=? (substring haystack i (+ i n-len)) needle) i]
         [else (loop (add1 i))]))]))