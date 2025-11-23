(define/contract (find-largest-outlier nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([evens (filter even? nums)]
         [odds (filter odd? nums)]
         [outliers (if (> (length evens) (length odds)) odds evens)])
    (if (null? outliers)
        -1
        (apply max outliers))))