(define/contract (rearrange-array nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([pos (filter positive? nums)]
         [neg (filter negative? nums)]
         [result '()])
    (for ([p pos] [n neg])
      (set! result (cons p (cons n result))))
    (reverse result)))