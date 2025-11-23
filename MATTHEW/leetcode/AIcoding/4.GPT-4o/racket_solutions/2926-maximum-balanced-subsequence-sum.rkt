(define (maximumBalancedSubsequenceSum nums)
  (define n (length nums))
  (define dp (make-vector (+ n 1) 0))
  (define max-sum 0)

  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (= (vector-ref nums i) (vector-ref nums j))
        (vector-set! dp (add1 i) 
          (max (vector-ref dp (add1 i)) 
               (+ (vector-ref dp j) (vector-ref nums i))))))
    (set! max-sum (max max-sum (vector-ref dp (add1 i)))))

  max-sum)

(maximumBalancedSubsequenceSum (vector 1 2 3 2 1))