(define/contract (trim-mean arr)
  (-> (listof exact-integer?) flonum?)
  (let* ([sorted-arr (sort arr <)]
         [n (length sorted-arr)]
         [remove-count (quotient n 20)]
         [trimmed (take (drop sorted-arr remove-count) (- n (* 2 remove-count)))])
    (exact->inexact (/ (apply + trimmed) (length trimmed)))))