(define (count-max-or-subsets nums)
  (define (solve idx current-or)
    (if (= idx (length nums))
        (if (= current-or max-or) 1 0)
        (+ (solve (+ idx 1) current-or)
           (solve (+ idx 1) (bitwise-ior current-or (list-ref nums idx))))))

  (define max-or
    (foldl bitwise-ior 0 nums))

  (solve 0 0))