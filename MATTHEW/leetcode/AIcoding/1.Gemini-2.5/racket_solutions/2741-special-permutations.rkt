(define (special-permutations nums)
  (define n (vector-length nums))
  (define memo (make-hash))
  (define MOD 1000000007)

  (define (dp mask last-idx)
    (let* ([state (cons mask last-idx)]
           [cached-val (hash-ref memo state #f)])
      (if cached-val
          cached-val
          (begin
            (if (= mask (sub1 (expt 2 n)))
                (begin
                  (hash-set! memo state 1)
                  1)
                (let loop ([next-idx 0] [current-sum 0])
                  (if (= next-idx n)
                      (begin
                        (hash-set! memo state current-sum)
                        current-sum)
                      (let ([new-sum current-sum])
                        (if (zero? (bitwise-and mask (expt 2 next-idx)))
                            (let ([val-last (vector-ref nums last-idx)]
                                  [val-next (vector-ref nums next-idx)])
                              (if (or (zero? (remainder val-last val-next))
                                      (zero? (remainder val-next val-last)))
                                  (loop (+ next-idx 1) (remainder (+ new-sum (dp (bitwise-ior mask (expt 2 next-idx)) next-idx)) MOD))
                                  (loop (+ next-idx 1) new-sum)))
                            (loop (+ next-idx 1) new-sum))))))))))

  (let loop-init ([i 0] [total 0])
    (if (= i n)
        total
        (loop-init (+ i 1) (remainder (+ total (dp (expt 2 i) i)) MOD)))))