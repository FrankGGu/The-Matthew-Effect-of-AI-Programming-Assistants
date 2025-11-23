(define/contract (transportation-hub path)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([nodes (remove-duplicates (flatten path))]
         [n (length nodes)]
         [in-degree (make-hash)]
         [out-degree (make-hash)]
         [zero-out (make-hash)])
    (for ([node nodes])
      (hash-set! in-degree node 0)
      (hash-set! out-degree node 0))
    (for ([edge path])
      (let ([u (first edge)]
            [v (second edge)])
        (hash-update! out-degree u add1)
        (hash-update! in-degree v add1))
    (for ([(node deg) in-degree])
      (when (= deg (- n 1))
        (hash-set! zero-out node (hash-ref out-degree node))))
    (for/first ([(node deg) zero-out]
                #:when (= deg 0))
      node)
    -1))