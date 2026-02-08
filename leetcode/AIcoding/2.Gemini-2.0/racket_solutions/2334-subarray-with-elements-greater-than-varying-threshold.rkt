(define (valid-subarray? nums threshold k)
  (if (null? nums)
      #f
      (and (>= (length nums) k)
           (for/and ([num nums])
             (> num threshold)))))

(define (validSubarraySizeK nums threshold)
  (let loop ([k 1])
    (cond
      [(> k (length nums)) -1]
      [else
       (let loop2 ([start 0])
         (cond
           [(>= start (- (length nums) k - 1))
            (loop (add1 k))]
           [else
            (if (valid-subarray? (list-tail nums start k) threshold k)
                k
                (loop2 (add1 start))))])])))

(define (subarray-with-elements-greater-than-varying-threshold nums threshold)
  (define n (length nums))
  (let loop ([k n])
    (cond
      [(zero? k) -1]
      [else
       (let ([threshold-for-k (quotient threshold k)])
         (let loop2 ([start 0])
           (cond
             [(>= start (- n k -1)) (loop (sub1 k))]
             [else
              (let ([subarray (list-tail nums start k)])
                (if (and (>= (length subarray) k)
                         (for/and ([num subarray])
                           (> num threshold-for-k)))
                    k
                    (loop2 (add1 start))))])))]))))

(define (subarray-with-elements-greater-than-varying-threshold nums threshold)
  (define n (length nums))
  (let loop ([k n])
    (cond
      [(zero? k) -1]
      [else
       (let ([threshold-for-k (quotient threshold k)])
         (let loop2 ([start 0])
           (cond
             [(>= start (- n k -1)) (loop (sub1 k))]
             [else
              (let ([subarray (sublist nums start (+ start k))])
                (if (and (>= (length subarray) k)
                         (for/and ([num subarray])
                           (> num threshold-for-k)))
                    k
                    (loop2 (add1 start))))])))]))))