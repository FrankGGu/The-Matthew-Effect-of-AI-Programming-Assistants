(define (subarray-sum-k nums k)
  (define (helper nums k prefix-sums count)
    (cond
      [(empty? nums) count]
      [else
       (let* ([current-prefix-sum (+ (car nums) (if (empty? prefix-sums) 0 (car prefix-sums)))]
              [new-count (+ count (hash-ref prefix-sums (- current-prefix-sum k) 0))])
         (helper (cdr nums) k (cons current-prefix-sum prefix-sums)
                 (hash-update prefix-sums current-prefix-sum (λ (v) (+ v 1)) 1)
                 new-count))]))

  (helper nums k (list) (make-hash)))