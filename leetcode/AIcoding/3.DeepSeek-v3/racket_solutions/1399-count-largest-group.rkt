(define/contract (count-largest-group n)
  (-> exact-integer? exact-integer?)
  (define (digit-sum x)
    (let loop ([x x] [sum 0])
      (if (zero? x)
          sum
          (loop (quotient x 10) (+ sum (remainder x 10))))))
  (let ([groups (make-hash)])
    (for ([i (in-range 1 (add1 n))])
      (let ([sum (digit-sum i)])
        (hash-update! groups sum add1 0)))
    (let* ([counts (hash-values groups)]
           [max-count (apply max counts)])
      (count (lambda (x) (= x max-count)) counts))))