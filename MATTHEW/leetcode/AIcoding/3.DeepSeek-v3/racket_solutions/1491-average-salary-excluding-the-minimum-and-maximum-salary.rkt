(define/contract (average salary)
  (-> (listof exact-integer?) flonum?)
  (let* ([sorted (sort salary <)]
         [trimmed (take (drop sorted 1) (- (length sorted) 2))])
    (/ (apply + trimmed) (length trimmed))))