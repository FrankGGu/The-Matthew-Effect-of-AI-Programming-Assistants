(define/contract (number-of-arithmetic-slices nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)]
        [dp (make-hash)]
        [res 0])
    (for ([i (in-range n)])
    (for ([i (in-range n)])
    (for ([i (in-range n)])
    (for ([j (in-range i)])
      (let* ([diff (- (list-ref nums i) (list-ref nums j))]
             [cnt (hash-ref (hash-ref dp j (hash)) diff 0)]
             [prev (hash-ref (hash-ref dp i (hash)) diff 0)])
        (set! res (+ res cnt))
        (hash-set! dp i (hash-set (hash-ref dp i (hash)) diff (+ prev cnt 1)))))
    res))