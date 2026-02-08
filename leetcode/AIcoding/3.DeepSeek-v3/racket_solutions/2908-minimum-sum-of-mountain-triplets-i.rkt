(define/contract (minimum-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define min-sum +inf.0)
  (for* ([i (in-range n)]
         [j (in-range (add1 i) n)]
         [k (in-range (add1 j) n)])
    (when (and (< (list-ref nums i) (list-ref nums j))
               (> (list-ref nums j) (list-ref nums k)))
      (set! min-sum (min min-sum (+ (list-ref nums i) (list-ref nums j) (list-ref nums k))))))
  (if (= min-sum +inf.0) -1 min-sum))