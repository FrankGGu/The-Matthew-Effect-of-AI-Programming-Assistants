(define (min-sub-array-len target nums)
  (let* ([n (vector-length nums)]
         [min-len +inf.0]
         [current-sum 0]
         [left 0])
    (for ([right (in-range n)])
      (set! current-sum (+ current-sum (vector-ref nums right)))
      (while (>= current-sum target)
        (set! min-len (min min-len (add1 (- right left))))
        (set! current-sum (- current-sum (vector-ref nums left)))
        (set! left (add1 left))))
    (if (= min-len +inf.0)
        0
        (inexact->exact min-len))))