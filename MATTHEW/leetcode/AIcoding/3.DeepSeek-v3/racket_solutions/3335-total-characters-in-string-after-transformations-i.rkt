(define/contract (maximum-length s transformations)
  (-> string? (listof (listof string?)) exact-integer?)
  (let* ([trans (make-hash)]
         [max-len 0]
         [n (string-length s)]
         [dp (make-vector (add1 n) 0)])
    (for ([t transformations])
      (hash-set! trans (string-ref (first t) 0) (string-ref (second t) 0)))
    (vector-set! dp n 0)
    (for ([i (in-range (sub1 n) (sub1 0) -1)])
    (for ([i (in-range (sub1 n) -1 -1)])
      (vector-set! dp i (add1 (vector-ref dp (add1 i))))
      (when (hash-has-key? trans (string-ref s i))
        (let ([c (hash-ref trans (string-ref s i))])
          (when (and (< (add1 i) n) (char=? c (string-ref s (add1 i))))
            (vector-set! dp i (max (vector-ref dp i) (+ 2 (vector-ref dp (+ 2 i))))))))
      (set! max-len (max max-len (vector-ref dp i))))
    max-len))