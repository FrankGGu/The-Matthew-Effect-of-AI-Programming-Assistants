(define (array-nesting nums)
  (define (dfs i visited)
    (if (or (>= i (length nums)) (vector-ref visited i))
        0
        (begin
          (vector-set! visited i #t)
          (+ 1 (dfs (vector-ref nums i) visited)))))
  (let ((visited (make-vector (length nums) #f)))
    (for/fold ((max-length 0))
              ((i (in-range (length nums))))
      (if (vector-ref visited i)
          max-length
          (max max-length (dfs i visited))))))