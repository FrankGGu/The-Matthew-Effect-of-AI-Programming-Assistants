(define/contract (minimum-abs-difference arr)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let* ([sorted-arr (sort arr <)]
         [min-diff (for/fold ([min-diff +inf.0])
                             ([i (in-range 1 (length sorted-arr))])
                     (let ([diff (- (list-ref sorted-arr i) (list-ref sorted-arr (- i 1)))])
                       (min min-diff diff)))]
         [result (for/list ([i (in-range 1 (length sorted-arr))]
                            #:when (= (- (list-ref sorted-arr i) (list-ref sorted-arr (- i 1))) min-diff))
                   (list (list-ref sorted-arr (- i 1)) (list-ref sorted-arr i)))])
    result))