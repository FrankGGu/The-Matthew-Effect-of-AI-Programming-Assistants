(define/contract (largest-divisible-subset nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (if (null? nums)
      '()
      (let* ([sorted-nums (sort nums <)]
             [n (length sorted-nums)]
             [dp (make-vector n 1)]
             [prev (make-vector n -1)]
             [max-len 1]
             [max-idx 0])
        (for ([i (in-range 1 n)])
          (for ([j (in-range 0 i)])
            (when (zero? (modulo (list-ref sorted-nums i) (list-ref sorted-nums j)))
              (when (> (+ (vector-ref dp j) 1) (vector-ref dp i))
                (vector-set! dp i (+ (vector-ref dp j) 1))
                (vector-set! prev i j)))
          (when (> (vector-ref dp i) max-len)
            (set! max-len (vector-ref dp i))
            (set! max-idx i)))
        (let loop ([idx max-idx] [res '()])
          (if (= idx -1)
              res
              (loop (vector-ref prev idx) (cons (list-ref sorted-nums idx) res))))))