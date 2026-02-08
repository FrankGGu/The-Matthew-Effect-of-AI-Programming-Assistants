(define/contract (max-chunks-to-sorted arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort arr <)]
         [max1 0]
         [max2 0]
         [res 0])
    (for ([i (in-range (length arr))]
      (set! max1 (max max1 (list-ref arr i)))
      (set! max2 (max max2 (list-ref sorted i)))
      (when (= max1 max2)
        (set! res (+ res 1))))
    res))