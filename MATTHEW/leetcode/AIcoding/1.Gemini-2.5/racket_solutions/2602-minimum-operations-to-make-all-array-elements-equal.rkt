(define (min-operations-to-make-all-array-elements-equal nums queries)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [nums-vec (list->vector sorted-nums)]
         [prefix-sums (make-vector (+ n 1) 0)]
         [_ (for ([i (in-range n)])
              (vector-set! prefix-sums (+ i 1)
                           (+ (vector-ref prefix-sums i) (vector-ref nums-vec i))))]
         [total-sum (vector-ref prefix-sums n)])

    (define (binary-search-upper-bound vec target)
      (let loop ([low 0] [high (vector-length vec)] [ans (vector-length vec)])
        (if (< low high)
            (let ([mid (quotient (+ low high) 2)])
              (if (> (vector-ref vec mid) target)
                  (loop low mid mid)
                  (loop (+ mid 1) high ans)))
            ans)))

    (for/list ([target queries])
      (let* ([idx (binary-search-upper-bound nums-vec target)]
             [sum-le (vector-ref prefix-sums idx)]
             [sum-gt (- total-sum sum-le)]
             [count-le idx]
             [count-gt (- n idx)])
        (+ (- (* count-le target) sum-le)
           (- sum-gt (* count-gt target)))))))