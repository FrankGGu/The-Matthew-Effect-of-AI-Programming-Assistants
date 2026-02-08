(define (count-triplets nums)
  (let* ([max-val (sub1 (expt 2 16))] ; Maximum possible value for nums[i] is 2^16 - 1
         [counts (make-vector (+ max-val 1) 0)])

    ; Precompute counts for all possible (a & b) values
    (for ([a nums])
      (for ([b nums])
        (let ([val (bitwise-and a b)])
          (vector-set! counts val (+ (vector-ref counts val) 1)))))

    ; Calculate total triplets (a & b & c) == 0
    (let ([total-triplets 0])
      (for ([c nums])
        (for ([val (in-range (+ max-val 1))]) ; Iterate through all possible (a & b) results
          (when (= (bitwise-and val c) 0)
            (set! total-triplets (+ total-triplets (vector-ref counts val))))))
      total-triplets)))