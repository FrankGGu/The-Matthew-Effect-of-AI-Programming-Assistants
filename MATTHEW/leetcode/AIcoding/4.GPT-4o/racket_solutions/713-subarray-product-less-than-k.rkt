(define (num-subarray-product-less-than-k nums k)
  (if (<= k 1) 
      0 
      (let loop ((left 0) (prod 1) (count 0))
        (for ((right (in-range (length nums))))
          (set! prod (* prod (list-ref nums right)))
          (while (>= prod k)
            (set! prod (/ prod (list-ref nums left)))
            (set! left (+ left 1)))
          (set! count (+ count (- right left 1)))
          )
        count)))

(num-subarray-product-less-than-k '(10 5 2 6) 100)