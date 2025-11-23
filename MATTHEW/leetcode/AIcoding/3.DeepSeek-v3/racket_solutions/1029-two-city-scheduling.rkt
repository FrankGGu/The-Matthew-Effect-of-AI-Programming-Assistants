(define/contract (two-city-sched-cost costs)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-costs (sort costs (lambda (a b) (< (- (car a) (cadr a)) (- (car b) (cadr b)))))]
         [n (/ (length costs) 2)]
         [total 0])
    (for ([i (in-range (length sorted-costs))])
      (if (< i n)
          (set! total (+ total (car (list-ref sorted-costs i))))
          (set! total (+ total (cadr (list-ref sorted-costs i))))))
    total))