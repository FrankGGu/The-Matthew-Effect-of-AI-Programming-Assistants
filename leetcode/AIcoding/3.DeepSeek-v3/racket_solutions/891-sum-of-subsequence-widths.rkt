(define/contract (sum-subseq-widths nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [modulo-const 1000000007]
         [pow2 (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (vector-set! pow2 i (modulo (* 2 (vector-ref pow2 (- i 1))) modulo-const)))
    (let loop ([i 0] [res 0])
      (if (= i n)
          res
          (let* ([left (vector-ref pow2 i)]
                 [right (vector-ref pow2 (- n i 1))]
                 [val (list-ref sorted-nums i)]
                 [contribution (modulo (* val (- left right)) modulo-const)])
            (loop (+ i 1) (modulo (+ res contribution) modulo-const))))))