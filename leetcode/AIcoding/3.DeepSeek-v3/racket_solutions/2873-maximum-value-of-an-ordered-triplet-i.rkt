(define/contract (maximum-triplet-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define max-val 0)
  (for* ([i (in-range n)]
         [j (in-range (add1 i) n)]
         [k (in-range (add1 j) n)])
    (define val (* (- (list-ref nums i) (list-ref nums j)) (list-ref nums k)))
    (when (> val max-val)
      (set! max-val val)))
  max-val)