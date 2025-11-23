(define/contract (subarray-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([count 0]
        [sum 0]
        [hash (make-hash '((0 . 1)))])
    (for ([num nums])
      (set! sum (+ sum num))
      (set! count (+ count (hash-ref hash (- sum k) 0)))
      (hash-set! hash sum (add1 (hash-ref hash sum 0))))
    count))