(define (maxSumNodes root)
  (define (helper node)
    (if (null? node)
        0
        (+ (max (helper (node-left node)) 0)
           (max (helper (node-right node)) 0)
           (node-value node))))
  (helper root))

(define (maxSum root)
  (if (null? root)
      0
      (max (maxSumNodes root) (max (maxSum (node-left root)) (maxSum (node-right root))))))