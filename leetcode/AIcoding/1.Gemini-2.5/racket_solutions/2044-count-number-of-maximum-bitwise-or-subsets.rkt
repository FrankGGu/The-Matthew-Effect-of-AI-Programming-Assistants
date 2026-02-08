(define (count-max-or-subsets nums)
  (define n (length nums))

  (define max-or-val
    (foldl bitwise-ior 0 nums))

  (define (helper index current-or)
    (cond
      ((= index n)
       (if (= current-or max-or-val)
           1
           0))
      (else
       (+ (helper (+ index 1) (bitwise-ior current-or (list-ref nums index)))
          (helper (+ index 1) current-or)))))

  (helper 0 0))