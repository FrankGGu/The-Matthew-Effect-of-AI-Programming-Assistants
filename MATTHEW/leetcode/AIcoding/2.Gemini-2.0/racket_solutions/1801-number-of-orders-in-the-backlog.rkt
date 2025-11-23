(define (get-number-of-backlog-orders orders)
  (define buy-heap (make-heap #:<= (lambda (x y) (<= (car x) (car y)))))
  (define sell-heap (make-heap #:>= (lambda (x y) (>= (car x) (car y)))))
  (define mod (expt 10 9) + 7)

  (for-each (lambda (order)
              (let ([price (car order)]
                    [amount (cadr order)]
                    [order-type (caddr order)])
                (cond
                  [(equal? order-type 0) ; Buy order
                   (let loop ([amount amount])
                     (cond
                       [(and (not (heap-empty? sell-heap))
                             (<= (car (heap-top sell-heap)) price))
                        (let ([sell-order (heap-top sell-heap)])
                          (heap-remove! sell-heap)
                          (let ([sell-amount (cadr sell-order)])
                            (cond
                              [(<= sell-amount amount)
                               (loop (- amount sell-amount))]
                              [else
                               (heap-add! sell-heap (list (car sell-order) (- sell-amount amount)))])))]
                       [else
                        (heap-add! buy-heap (list price amount))]))]
                  [else ; Sell order
                   (let loop ([amount amount])
                     (cond
                       [(and (not (heap-empty? buy-heap))
                             (>= (car (heap-top buy-heap)) price))
                        (let ([buy-order (heap-top buy-heap)])
                          (heap-remove! buy-heap)
                          (let ([buy-amount (cadr buy-order)])
                            (cond
                              [(<= buy-amount amount)
                               (loop (- amount buy-amount))]
                              [else
                               (heap-add! buy-heap (list (car buy-order) (- buy-amount amount)))])))]
                       [else
                        (heap-add! sell-heap (list price amount))]))])))
            orders)

  (define (heap-sum heap)
    (let loop ([sum 0])
      (if (heap-empty? heap)
          sum
          (let ([top (heap-top heap)])
            (heap-remove! heap)
            (loop (modulo (+ sum (cadr top)) mod))))))

  (modulo (+ (heap-sum buy-heap) (heap-sum sell-heap)) mod))