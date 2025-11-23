(define/contract (longest-substring s k)
  (-> string? exact-integer? exact-integer?)
  (define (helper s k start end)
    (if (>= start end)
        0
        (let* ([counts (make-hash)]
               [unique 0]
               [no-less-than-k 0]
               [max-len 0]
               [left start])
          (for ([i (in-range start end)])
            (let ([c (string-ref s i)])
              (hash-set! counts c (add1 (hash-ref counts c 0)))
              (when (= (hash-ref counts c) 1) (set! unique (add1 unique)))
              (when (= (hash-ref counts c) k) (set! no-less-than-k (add1 no-less-than-k)))))
          (if (= unique no-less-than-k)
              (- end start)
              (let loop ([left start] [right start])
                (if (>= right end)
                    max-len
                    (let ([c (string-ref s right)])
                      (hash-update! counts c sub1)
                      (when (= (hash-ref counts c) 0) (set! unique (sub1 unique)))
                      (when (= (hash-ref counts c) (sub1 k)) (set! no-less-than-k (sub1 no-less-than-k)))
                      (when (= unique no-less-than-k)
                        (set! max-len (max max-len (- right left)))
                      (loop (add1 left) (add1 right))))))))
  (helper s k 0 (string-length s)))