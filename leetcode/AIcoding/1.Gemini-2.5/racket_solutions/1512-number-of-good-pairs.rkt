(define (num-good-pairs nums)
  (let* ([max-val 100]
         [counts (make-vector (+ max-val 1) 0)])

    (for-each (lambda (num)
                (vector-set! counts num (+ (vector-ref counts num) 1)))
              nums)

    (for/sum ([k (in-vector counts)])
      (if (> k 1)
          (/ (* k (- k 1)) 2)
          0))))