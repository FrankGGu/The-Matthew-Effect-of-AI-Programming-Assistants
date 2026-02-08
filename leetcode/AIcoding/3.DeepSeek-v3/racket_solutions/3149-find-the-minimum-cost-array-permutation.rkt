(define/contract (min-cost-permutation nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define n (length nums))
  (define min-cost +inf.0)
  (define best-perm '())

  (define (permute lst start)
    (if (= start n)
        (let ([cost (calculate-cost lst)])
          (when (< cost min-cost)
            (set! min-cost cost)
            (set! best-perm (append lst '()))))
        (for ([i (in-range start n)])
          (let ([new-lst (swap lst start i)])
            (permute new-lst (add1 start))
            (swap new-lst start i))))

  (define (swap lst i j)
    (let ([tmp (list-ref lst i)])
      (list-set (list-set lst i (list-ref lst j)) j tmp))

  (define (calculate-cost perm)
    (let loop ([i 0] [sum 0])
      (if (>= i (sub1 n))
          sum
          (loop (add1 i) (+ sum (abs (- (list-ref perm i) (list-ref nums (list-ref perm (add1 i))))))))

  (permute (range n) 0)
  best-perm)