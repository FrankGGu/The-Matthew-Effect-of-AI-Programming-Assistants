(define (is-valid-serialization preorder)
  (let* ([nodes (string-split preorder ",")]
         [len (length nodes)])
    (let loop ([i 0] [slots 1])
      (cond
        [(= i len)
         (= slots 0)]
        [(< slots 1)
         #f]
        [else
         (let ([node (list-ref nodes i)])
           (if (string=? node "#")
               (loop (add1 i) (sub1 slots))
               (loop (add1 i) (+ (sub1 slots) 2))))]))))