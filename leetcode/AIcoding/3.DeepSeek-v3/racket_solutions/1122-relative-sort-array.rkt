(define/contract (relative-sort-array arr1 arr2)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([count (make-hash)]
         [not-in-arr2 (filter (lambda (x) (not (member x arr2))) arr1)]
         [sorted-not-in-arr2 (sort not-in-arr2 <)])
    (for ([num arr1])
      (hash-update! count num add1 0))
    (let loop ([arr2 arr2]
               [result '()])
      (if (null? arr2)
          (append result sorted-not-in-arr2)
          (let* ([num (car arr2)]
                 [cnt (hash-ref count num 0)]
                 [new-result (append result (make-list cnt num))])
            (loop (cdr arr2) new-result))))))