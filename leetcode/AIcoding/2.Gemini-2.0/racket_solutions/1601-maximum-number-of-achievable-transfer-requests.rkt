(define (maximum-requests n requests)
  (let loop ([i 0] [count 0])
    (cond
      [(= i (length requests)) count]
      [else
       (let ([next-count (loop (+ i 1) count)])
         (let ([balance (make-vector n 0)])
           (for ([j (in-range (length requests))])
             (cond
               [(and (bitwise-and i (expt 2 j)) (= (bitwise-and i (expt 2 j)) (expt 2 j)))
                (let ([from (vector-ref (list-ref requests j) 0)]
                      [to (vector-ref (list-ref requests j) 1)])
                  (vector-set! balance from (- (vector-ref balance from) 1))
                  (vector-set! balance to (+ (vector-ref balance to) 1)))]
               [else #f]))
           (if (andmap zero? (vector->list balance))
               (loop (+ i 1) (max count (+ (length (filter (λ (j) (and (bitwise-and i (expt 2 j)) (= (bitwise-and i (expt 2 j)) (expt 2 j))))) (range (length requests))))) next-count)
               next-count))])))
    )
  (loop 0 0))