(define/contract (mincost-to-hire-workers quality wage k)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? flonum?)
  (let* ([n (length quality)]
         [workers (for/list ([q quality] [w wage]) (cons q w))]
         [workers-sorted (sort workers (lambda (a b) (< (/ (cdr a) (car a)) (/ (cdr b) (car b)))))])
    (let loop ([i 0]
               [min-cost +inf.0]
               [max-heap '()]
               [sum-quality 0])
      (if (>= i n)
          (if (>= (length max-heap) k) min-cost +inf.0)
          (let* ([worker (list-ref workers-sorted i)]
                 [ratio (/ (cdr worker) (car worker))]
                 [new-sum-quality (+ sum-quality (car worker))]
                 [new-max-heap (cons (car worker) max-heap)]
                 [new-max-heap-sorted (sort new-max-heap >)])
            (if (>= (length new-max-heap-sorted) k)
                (let* ([removed (car new-max-heap-sorted)]
                       [updated-sum-quality (- new-sum-quality removed)]
                       [updated-max-heap (cdr new-max-heap-sorted)]
                       [current-cost (* ratio updated-sum-quality)])
                  (loop (add1 i) (min min-cost current-cost) updated-max-heap updated-sum-quality))
                (loop (add1 i) min-cost new-max-heap-sorted new-sum-quality)))))))