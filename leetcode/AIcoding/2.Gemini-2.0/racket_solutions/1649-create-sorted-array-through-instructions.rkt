(define (create-sorted-array instructions)
  (define mod 1000000007)
  (define n (length instructions))
  (define fenwick-tree (make-vector (add1 n) 0))

  (define (update index value)
    (let loop ([i (add1 index)])
      (when (<= i n)
        (vector-set! fenwick-tree i (modulo (+ (vector-ref fenwick-tree i) value) mod))
        (loop (+ i (logand (- i) i))))))

  (define (query index)
    (let loop ([i (add1 index)] [sum 0])
      (if (zero? i)
          sum
          (loop (- i (logand (- i) i)) (modulo (+ sum (vector-ref fenwick-tree i)) mod)))))

  (define (solve instructions)
    (let loop ([instructions instructions] [cost 0] [index 0])
      (if (null? instructions)
          cost
          (let ([instruction (car instructions)])
            (let ([less (query (sub1 instruction))]
                  [greater (- index (query instruction))])
              (let ([new-cost (min less greater)])
                (update instruction 1)
                (loop (cdr instructions) (modulo (+ cost new-cost) mod) (add1 index))))))))

  (solve instructions))