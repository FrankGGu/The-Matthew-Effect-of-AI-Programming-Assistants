(define (max-chunks-to-sorted-ii arr)
  (let* ([n (length arr)]
         [sorted-arr (sort (copy-list arr) <)]
         [prefix-sum-arr (make-vector (add1 n) 0)]
         [prefix-sum-sorted (make-vector (add1 n) 0)])

    (for ([i (in-range n)])
      (vector-set! prefix-sum-arr (add1 i) (+ (vector-ref prefix-sum-arr i) (list-ref arr i))))

    (for ([i (in-range n)])
      (vector-set! prefix-sum-sorted (add1 i) (+ (vector-ref prefix-sum-sorted i) (list-ref sorted-arr i))))

    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (if (= (vector-ref prefix-sum-arr (add1 i)) (vector-ref prefix-sum-sorted (add1 i)))
              (loop (add1 i) (add1 count))
              (loop (add1 i) count))))))