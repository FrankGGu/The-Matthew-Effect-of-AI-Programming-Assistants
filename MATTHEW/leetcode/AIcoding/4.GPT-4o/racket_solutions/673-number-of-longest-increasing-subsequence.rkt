(define (lengthOfLIS nums)
  (define n (length nums))
  (define dp (make-vector n 1))
  (define count (make-vector n 1))

  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (> (vector-ref nums i) (vector-ref nums j))
        (when (> (+ 1 (vector-ref dp j)) (vector-ref dp i))
          (vector-set! dp i (+ 1 (vector-ref dp j)))
          (vector-set! count i (vector-ref count j))
          )
        (when (= (+ 1 (vector-ref dp j)) (vector-ref dp i))
          (vector-set! count i (+ (vector-ref count i) (vector-ref count j)))
          ))))

  (define max-len (apply max (vector->list dp)))
  (define total-count (apply + (for/list ([i (in-range n)] 
                                          #:when (= (vector-ref dp i) max-len)) 
                                  (vector-ref count i))))
  total-count)

(define (findNumberOfLIS nums)
  (lengthOfLIS nums))