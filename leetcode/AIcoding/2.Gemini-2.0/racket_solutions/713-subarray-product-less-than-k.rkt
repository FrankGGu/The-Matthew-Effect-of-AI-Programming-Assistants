(define (numSubarrayProductLessThanK nums k)
  (define n (length nums))
  (define (solve left right product count)
    (cond
      [(>= left n) count]
      [(> right n) (solve (+ left 1) (+ left 1) 1 count)]
      [(< product k) (solve left (+ right 1) (* product (list-ref nums right)) (+ count (- right left)))]
      [else (solve (+ left 1) (+ left 1) 1 count)]))

  (if (<= k 1)
      0
      (solve 0 0 1 0)))