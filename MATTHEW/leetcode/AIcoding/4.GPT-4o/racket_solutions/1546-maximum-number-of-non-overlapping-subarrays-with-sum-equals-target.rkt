(define (maxNonOverlapping nums target)
  (define counts (make-hash))
  (define current-sum 0)
  (define result 0)
  (hash-set! counts 0 1)
  (for ([num nums])
    (set! current-sum (+ current-sum num))
    (if (hash-has? counts (- current-sum target))
        (begin
          (set! result (+ result 1))
          (set! current-sum 0)
          (set! counts (make-hash)))
        (hash-set! counts current-sum (add1 (hash-ref counts current-sum 0)))))
  result)

(maxNonOverlapping '(1 1 1 1 1) 2) ; Output: 2