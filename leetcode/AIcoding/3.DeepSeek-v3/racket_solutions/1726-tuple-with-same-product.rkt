(define/contract (tuple-same-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([product-count (make-hash)]
        [n (length nums)])
    (for* ([i (in-range n)]
           [j (in-range (add1 i) n)])
      (let ([prod (* (list-ref nums i) (list-ref nums j))])
        (hash-update! product-count prod add1 0)))
    (let ([res 0])
      (hash-for-each product-count
                     (lambda (k v)
                       (set! res (+ res (* v (sub1 v) 4)))))
      res)))