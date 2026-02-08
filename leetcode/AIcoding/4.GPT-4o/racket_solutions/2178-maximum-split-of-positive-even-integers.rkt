(define (maximum-even-split(n))
  (if (odd? n) '()
      (let loop ((x n) (result '()))
        (if (= x 0)
            result
            (loop (- x 2) (cons x result))))))

(maximum-even-split n)