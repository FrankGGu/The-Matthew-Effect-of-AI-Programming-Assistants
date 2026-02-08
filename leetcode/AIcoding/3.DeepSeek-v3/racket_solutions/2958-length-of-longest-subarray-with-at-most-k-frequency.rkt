(define/contract (max-subarray-length nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([left 0]
        [max-len 0]
        [freq (make-hash)])
    (for ([right (in-range (length nums))])
      (hash-update! freq (list-ref nums right) add1 0)
      (while (> (hash-ref freq (list-ref nums right)) k)
        (hash-update! freq (list-ref nums left) sub1)
        (set! left (add1 left))))
      (set! max-len (max max-len (- (add1 right) left))))
    max-len))