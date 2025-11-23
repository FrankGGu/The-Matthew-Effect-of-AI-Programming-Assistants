(define/contract (max-profit-assignment difficulty profit worker)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([jobs (sort (map cons difficulty profit) (lambda (a b) (< (car a) (car b))))]
         [worker (sort worker <)]
         [n (length jobs)]
         [m (length worker)]
         [i 0]
         [j 0]
         [max-profit 0]
         [total 0])
    (for ([w worker])
      (while (and (< i n) (>= w (car (list-ref jobs i))))
        (set! max-profit (max max-profit (cdr (list-ref jobs i))))
        (set! i (add1 i)))
      (set! total (+ total max-profit)))
    total))