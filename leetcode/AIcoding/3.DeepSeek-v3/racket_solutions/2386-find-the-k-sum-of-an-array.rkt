(define/contract (k-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [total (foldl + 0 (map abs nums))]
         [nums (sort (map abs nums) <)])
    (let loop ([heap (make-heap (λ (a b) (< (car a) (car b))))]
               [visited (make-hash)]
               [result 0])
      (heap-add! heap (cons (- total (list-ref nums 0)) 0))
      (hash-set! visited (cons (- total (list-ref nums 0)) #t)
      (for ([i (in-range k)])
        (let* ([current (heap-min heap)]
               [sum (car current)]
               [idx (cdr current)])
          (heap-remove-min! heap)
          (set! result sum)
          (when (< idx (- n 1))
            (let ([new-sum1 (+ sum (list-ref nums idx) (- (list-ref nums (+ idx 1))))]
                  [new-sum2 (+ sum (- (list-ref nums (+ idx 1))))])
              (unless (hash-has-key? visited (cons new-sum1 idx))
                (heap-add! heap (cons new-sum1 (+ idx 1)))
                (hash-set! visited (cons new-sum1 (+ idx 1)) #t))
              (unless (hash-has-key? visited (cons new-sum2 (+ idx 1)))
                (heap-add! heap (cons new-sum2 (+ idx 1)))
                (hash-set! visited (cons new-sum2 (+ idx 1)) #t))))))
      result)))