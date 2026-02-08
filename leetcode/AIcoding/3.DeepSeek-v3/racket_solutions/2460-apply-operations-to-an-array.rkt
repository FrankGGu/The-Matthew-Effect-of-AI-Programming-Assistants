(define/contract (apply-operations nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums] [i 0])
    (cond
      [(>= i (sub1 (length nums))) nums]
      [(= (list-ref nums i) (list-ref nums (add1 i)))
       (loop (list-set (list-set nums i (* 2 (list-ref nums i))) (add1 i) 0) (add1 i))]
      [else (loop nums (add1 i))])))
  (filter (lambda (x) (not (zero? x))) nums))