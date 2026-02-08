(define/contract (slowest-key release-times keys)
  (-> (listof exact-integer?) (listof char?) char?)
  (let loop ([i 1]
             [max-duration (- (list-ref release-times 0) 0)]
             [result (list-ref keys 0)])
    (if (>= i (length release-times))
        result
        (let ([duration (- (list-ref release-times i) (list-ref release-times (- i 1)))])
          (cond
            [(> duration max-duration) (loop (+ i 1) duration (list-ref keys i))]
            [(and (= duration max-duration) (char>? (list-ref keys i) result)) (loop (+ i 1) max-duration (list-ref keys i))]
            [else (loop (+ i 1) max-duration result)])))))