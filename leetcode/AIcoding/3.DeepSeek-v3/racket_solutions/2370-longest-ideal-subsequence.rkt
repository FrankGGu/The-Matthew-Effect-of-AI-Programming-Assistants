(define/contract (longest-ideal-string s k)
  (-> string? exact-integer? exact-integer?)
  (let* ([n (string-length s)]
         [dp (make-vector 26 0)]
         [res 0])
    (for ([i (in-range n)])
      (let* ([c (char->integer (string-ref s i))]
             [current (- c (char->integer #\a))]
             [start (max 0 (- current k))]
             [end (min 25 (+ current k))]
             [max-prev 0])
        (for ([j (in-range start (+ end 1))])
          (set! max-prev (max max-prev (vector-ref dp j))))
      (vector-set! dp current (+ max-prev 1))
      (set! res (max res (vector-ref dp current))))
    res))