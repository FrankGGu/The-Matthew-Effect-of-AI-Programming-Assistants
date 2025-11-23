(define (minimum-groups (nums (vectorof integer?)))
  (let* ((counts (make-hash))
         (_ (for ([n (in-vector nums)])
              (hash-update! counts n add1 0)))
         (vals (sort (hash-values counts) <))
         (n (length vals)))
    (let loop ([k 1])
      (if (> k (car vals))
          n
          (let ([possible? #t])
            (for ([v (in-list vals)])
              (let ([q (quotient v k)]
                    [r (remainder v k)])
                (if (and (< r 0) (< r (- k)))
                    (set! possible? #f)
                    (void))))
            (if possible?
                (let loop2 ([i 0] [res 0])
                  (if (= i n)
                      res
                      (let ([v (list-ref vals i)])
                        (loop2 (+ i 1) (+ res (quotient (+ v (- 1) k) k))))))
                (loop (+ k 1)))))))