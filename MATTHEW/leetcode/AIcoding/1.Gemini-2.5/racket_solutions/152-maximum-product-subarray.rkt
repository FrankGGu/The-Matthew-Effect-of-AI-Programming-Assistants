(define (max-product nums)
  (let* ((first-num (car nums))
         (initial-max-prod first-num)
         (initial-min-prod first-num)
         (initial-result first-num))
    (for/fold ((max-prod initial-max-prod)
               (min-prod initial-min-prod)
               (result initial-result))
              ((n (cdr nums)))
      (let* ((temp-max-prod (max n (* n max-prod) (* n min-prod)))
             (temp-min-prod (min n (* n max-prod) (* n min-prod))))
        (values temp-max-prod
                temp-min-prod
                (max result temp-max-prod))))))