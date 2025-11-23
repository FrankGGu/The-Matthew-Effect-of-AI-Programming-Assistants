(define (min-subarray-len target nums)
  (define n (length nums))
  (define min-len +inf.0)
  (define current-sum 0)
  (define left 0)

  (for ([right (in-range n)])
    (set! current-sum (+ current-sum (list-ref nums right)))
    (while (>= current-sum target)
      (set! min-len (min min-len (+ 1 (- right left))))
      (set! current-sum (- current-sum (list-ref nums left)))
      (set! left (add1 left))))

  (if (= min-len +inf.0)
      0
      min-len))