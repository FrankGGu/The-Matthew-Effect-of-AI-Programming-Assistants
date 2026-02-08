(define/contract (get-sum-absolute-differences nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [prefix (make-vector (+ n 1) 0)]
         [result '()])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (list-ref nums i)))
    (for ([i (in-range n)])
      (let* ([left-sum (* (list-ref nums i) i)]
             [right-sum (- (* (list-ref nums i) (- n i 1)) (- (vector-ref prefix n) (vector-ref prefix (+ i 1))))]
             [total (+ left-sum right-sum)])
        (set! result (cons total result))))
    (reverse result)))