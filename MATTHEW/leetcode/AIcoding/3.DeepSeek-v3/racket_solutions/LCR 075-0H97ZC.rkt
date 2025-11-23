(define/contract (relative-sort-array arr1 arr2)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let ([order (make-hash)])
    (for ([i (in-naturals)]
          [num (in-list arr2)])
      (hash-set! order num i))
    (sort arr1 (lambda (x y)
                 (let ([x-in? (hash-has-key? order x)]
                       [y-in? (hash-has-key? order y)])
                   (cond
                     [(and x-in? y-in?) (< (hash-ref order x) (hash-ref order y))]
                     [(and (not x-in?) (not y-in?)) (< x y)]
                     [x-in? #t]
                     [else #f]))))))