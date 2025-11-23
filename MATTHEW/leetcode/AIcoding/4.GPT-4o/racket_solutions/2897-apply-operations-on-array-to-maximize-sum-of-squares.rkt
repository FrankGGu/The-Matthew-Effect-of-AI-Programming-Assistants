(define (maximize-sum-squares nums)
  (define (apply-operations nums)
    (for ([i (in-range (sub1 (length nums)))])
      (when (= (list-ref nums i) (list-ref nums (+ i 1)))
        (set! nums (vector-set! nums i (* 2 (list-ref nums i)))
              (vector-set! nums (+ i 1) 0))))
    nums)

  (define (sum-squares nums)
    (apply + (map (lambda (x) (* x x)) (filter (lambda (x) (> x 0)) nums))))

  (define final-nums (apply-operations nums))
  (sum-squares final-nums))

(maximize-sum-squares nums)