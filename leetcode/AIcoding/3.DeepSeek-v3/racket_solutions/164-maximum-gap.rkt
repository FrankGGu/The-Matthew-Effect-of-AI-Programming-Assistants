(define/contract (maximum-gap nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (< (length nums) 2)
      0
      (let* ([sorted-nums (sort nums <)]
             [max-gap 0])
        (for ([i (in-range 1 (length sorted-nums))])
          (let ([gap (- (list-ref sorted-nums i) (list-ref sorted-nums (- i 1)))])
            (when (> gap max-gap)
              (set! max-gap gap))))
        max-gap)))