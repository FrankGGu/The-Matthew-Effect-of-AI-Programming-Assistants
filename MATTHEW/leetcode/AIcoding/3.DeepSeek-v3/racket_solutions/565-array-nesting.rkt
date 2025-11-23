(define/contract (array-nesting nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)]
        [visited (make-vector (length nums) #f)]
        [max-len 0])
    (for ([i (in-range n)])
      (when (not (vector-ref visited i))
        (let loop ([j i]
                   [len 0])
          (if (vector-ref visited j)
              (set! max-len (max max-len len))
              (begin
                (vector-set! visited j #t)
                (loop (list-ref nums j) (add1 len))))))))
    max-len))