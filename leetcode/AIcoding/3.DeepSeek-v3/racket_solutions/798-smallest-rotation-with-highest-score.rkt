(define/contract (best-rotation nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [bad (make-vector n 0)])
    (for ([i (in-range n)]
          [num (in-list nums)])
      (let ([left (modulo (- i num 1) n)]
            [right (modulo (- i 1) n)])
        (vector-set! bad left (add1 (vector-ref bad left)))
        (when (>= right 0)
          (vector-set! bad right (sub1 (vector-ref bad right))))
        (when (< left right)
          (vector-set! bad 0 (add1 (vector-ref bad 0))))))
    (let loop ([i 1] [best-score 0] [best-k 0] [current-score (- n (vector-ref bad 0))])
      (if (>= i n)
          best-k
          (let* ([current-score (+ current-score (vector-ref bad (sub1 i)))]
                 [new-best-k (if (> current-score best-score) i best-k)]
                 [new-best-score (max current-score best-score)])
            (loop (add1 i) new-best-score new-best-k current-score))))))