(define (decode-xored-permutation encoded-list)
  (let* ([encoded (list->vector encoded-list)]
         [n (+ (vector-length encoded) 1)]
         [total-xor (for/fold ([acc 0])
                               ([i (in-range 1 (add1 n))])
                               (bitwise-xor acc i))]
         [xor-of-p-except-p0 (for/fold ([acc 0])
                                       ([i (in-range 1 (- n 1)) (step 2)])
                                       (bitwise-xor acc (vector-ref encoded i)))]
         [p0 (bitwise-xor total-xor xor-of-p-except-p0)]
         [perm (make-vector n 0)])

    (vector-set! perm 0 p0)

    (for ([i (in-range 0 (- n 1))])
      (vector-set! perm (add1 i) (bitwise-xor (vector-ref perm i) (vector-ref encoded i))))

    (vector->list perm)))