(define (count-non-decreasing-subarrays-after-k-operations nums k)
  (let* ([n (length nums)]
         [count (make-vector n 0)])
    (for ([i (in-range n)])
      (vector-set! count i 1))
    (for ([i (in-range 1 n)])
      (for ([j (in-range i n)])
        (let loop ([l (subvector nums (- j i) (+ 1 j))]
                   [ops k])
          (cond
            [(empty? l)
             (vector-set! count j (+ (vector-ref count j) 1))]
            [(= (length l) 1)
             (vector-set! count j (+ (vector-ref count j) 1))]
            [else
             (let ([max-val (apply max (vector->list l))])
               (let loop2 ([idx 0]
                           [valid? #t]
                           [ops-used 0])
                 (cond
                   [(>= idx (length l))
                    (if valid?
                        (vector-set! count j (+ (vector-ref count j) 1))
                        #f)]
                   [else
                    (if (<= (vector-ref l idx) max-val)
                        (loop2 (+ idx 1) valid? ops-used)
                        (if (> ops 0)
                            (loop2 (+ idx 1) valid? (+ ops-used 1))
                            (loop2 (+ idx 1) #f ops-used)))))])))]))))
    (apply + (vector->list count))))