(define (can-partition-k-subsets nums k)
  (define (can-partition? nums k target)
    (define (backtrack start k current-sum)
      (if (= k 1) #t
          (if (= current-sum target)
              (backtrack 0 (- k 1) 0)
              (for/or ([i (in-range start (length nums))])
                (when (and (not (vector-ref visited i))
                           (<= current-sum (+ (vector-ref nums i))))
                  (vector-set! visited i #t)
                  (if (backtrack (add1 i) k (+ current-sum (vector-ref nums i)))
                      #t
                      (begin (vector-set! visited i #f) #f))))))
    (define total (apply + nums))
    (if (or (< total 0) (not (= (modulo total k) 0))) #f
        (begin
          (set! visited (make-vector (length nums) #f))
          (backtrack 0 k 0))))
  (define visited #f)
  (let* ((total (apply + nums))
         (target (/ total k)))
    (if (or (< total 0) (not (= (modulo total k) 0))) #f
        (can-partition? (vector->list (vector nums)) k target))))

(can-partition-k-subsets nums k)