(define (maximum-strength nums k)
  (define n (length nums))

  (define (max-product lst)
    (if (null? lst)
        0
        (apply * lst)))

  (define (solve idx count selected)
    (cond
      [(= count k) (max-product selected)]
      [(= idx n) -inf.0]
      [else
       (max (solve (+ idx 1) count selected)
            (solve (+ idx 1) (+ count 1) (append selected (list (list-ref nums idx)))))]))

  (if (= k 0)
      1
      (solve 0 0 '())))