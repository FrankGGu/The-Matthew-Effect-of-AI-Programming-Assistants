(define (get-number-of-backlog-orders orders)
  (define sell-pq (make-priority-queue (lambda (a b) (<= (car a) (car b)))))
  (define buy-pq (make-priority-queue (lambda (a b) (>= (car a) (car b)))))

  (define (process-order price amount order-type)
    (cond
      [(= order-type 0) ; buy order
       (let loop ([amount amount])
         (if (or (zero? amount) (priority-queue-empty? sell-pq) (> price (car (priority-queue-min sell-pq))))
             (when (positive? amount)
               (priority-queue-insert! buy-pq (cons price amount)))
             (let* ([min-sell (priority-queue-min sell-pq)]
                    [sell-price (car min-sell)]
                    [sell-amount (cdr min-sell)])
               (if (<= sell-price price)
                   (let ([delta (min amount sell-amount)])
                     (priority-queue-remove-min! sell-pq)
                     (if (> sell-amount delta)
                         (priority-queue-insert! sell-pq (cons sell-price (- sell-amount delta))))
                     (loop (- amount delta)))
                   (priority-queue-insert! buy-pq (cons price amount))))))]
      [(= order-type 1) ; sell order
       (let loop ([amount amount])
         (if (or (zero? amount) (priority-queue-empty? buy-pq) (< price (car (priority-queue-min buy-pq))))
             (when (positive? amount)
               (priority-queue-insert! sell-pq (cons price amount)))
             (let* ([max-buy (priority-queue-min buy-pq)]
                    [buy-price (car max-buy)]
                    [buy-amount (cdr max-buy)])
               (if (>= buy-price price)
                   (let ([delta (min amount buy-amount)])
                     (priority-queue-remove-min! buy-pq)
                     (if (> buy-amount delta)
                         (priority-queue-insert! buy-pq (cons buy-price (- buy-amount delta))))
                     (loop (- amount delta)))
                   (priority-queue-insert! sell-pq (cons price amount))))))]))

  (for ([order orders])
    (let ([price (first order)]
          [amount (second order)]
          [order-type (third order)])
      (process-order price amount order-type)))

  (define (sum-pq pq)
    (let loop ([sum 0])
      (if (priority-queue-empty? pq)
          sum
          (let ([entry (priority-queue-min pq)])
            (priority-queue-remove-min! pq)
            (loop (modulo (+ sum (cdr entry)) 1000000007))))))

  (modulo (+ (sum-pq buy-pq) (sum-pq sell-pq)) 1000000007))