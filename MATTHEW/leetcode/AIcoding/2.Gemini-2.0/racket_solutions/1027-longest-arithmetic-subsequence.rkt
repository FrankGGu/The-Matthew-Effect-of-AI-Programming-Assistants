(define (longestArithSeqLength nums)
  (let* ([n (length nums)]
         [dp (make-vector n (make-hash))]
         [max-len 0])
    (for* ([i (in-range 1 n)]
           [j (in-range 0 i)])
      (let* ([diff (- (list-ref nums i) (list-ref nums j))]
             [len (if (hash-has-key? (vector-ref dp j) diff)
                      (+ 1 (hash-ref (vector-ref dp j) diff))
                      2)])
        (hash-set! (vector-ref dp i) diff len)
        (set! max-len (max max-len len))))
    max-len))