(define (minimum-average-difference nums)
  (define n (length nums))
  (define prefix-sum (make-vector n 0))
  (vector-set! prefix-sum 0 (vector-ref nums 0))

  (for ([i (in-range 1 n)])
    (vector-set! prefix-sum i (+ (vector-ref prefix-sum (- i 1)) (vector-ref nums i))))

  (define min-avg-diff (lambda (idx)
    (define left-avg (/ (vector-ref prefix-sum idx) (+ idx 1)))
    (define right-avg 
      (if (< idx (- n 1)) 
          (/ (- (vector-ref prefix-sum (- n 1)) (vector-ref prefix-sum idx)) (- n idx 1))
          0))
    (abs (- left-avg right-avg)))

  (define min-diff (min-avg-diff 0))
  (define result 0)

  (for ([i (in-range n)])
    (define diff (min-avg-diff i))
    (when (< diff min-diff)
      (set! min-diff diff)
      (set! result i)))

  result)

(minimum-average-difference (vector 2 5 3 9 5 3))