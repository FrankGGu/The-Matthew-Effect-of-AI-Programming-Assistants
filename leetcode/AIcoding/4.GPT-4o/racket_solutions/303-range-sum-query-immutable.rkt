(define RangeSumQuery
  (class object%
    (super-new)
    (define/public (initialize nums)
      (set! nums (vector->list nums))
      (set! prefix-sum (map (lambda (x) (if (null? x) 0 (+ (car (last nums)) x))) (for/list ((i (in-range (length nums)))) (if (zero? i) (list (list-ref nums i)) (+ (list-ref nums i) (if (zero? i) 0 (list-ref prefix-sum (- i 1)))))))))

    (define/public (sumRange i j)
      (if (zero? i)
          (list-ref prefix-sum j)
          (- (list-ref prefix-sum j) (list-ref prefix-sum (- i 1)))))
  ))