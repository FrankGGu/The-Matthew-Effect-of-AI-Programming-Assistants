(define (left-right-sum-differences nums)
  (define n (length nums))
  (define left-sum (make-vector n 0))
  (define right-sum (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! left-sum i (if (= i 0) 0 (+ (vector-ref left-sum (- i 1)) (vector-ref nums (- i 1))))))

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! right-sum i (if (= i (- n 1)) 0 (+ (vector-ref right-sum (+ i 1)) (vector-ref nums (+ i 1))))))

  (for/list ([i (in-range n)])
    (- (vector-ref left-sum i) (vector-ref right-sum i))))