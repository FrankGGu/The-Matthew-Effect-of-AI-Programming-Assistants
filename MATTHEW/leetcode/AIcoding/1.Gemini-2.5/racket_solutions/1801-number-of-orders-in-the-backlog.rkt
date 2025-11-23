(require data/heap)

(define (get-number-of-orders orders)
  (define MOD 1000000007)

  ; Max-heap for buy orders (highest price first)
  ; Stores (price . amount)
  ; Comparison function: (lambda (a b) (> (car a) (car b)))
  (define buy-backlog (make-heap (lambda (a b) (> (car a) (car b)))))

  ; Min-heap for sell orders (lowest price first)
  ; Stores (price . amount)
  ; Comparison function: (lambda (a b) (< (car a) (car b)))
  (define sell-backlog (make-heap (lambda (a b) (< (car a) (car b)))))

  (for-each
   (lambda (order)
     (let* ((price (list-ref order 0))
            (amount (list-ref order 1))
            (type (list-ref order 2))) ; 0 for buy, 1 for sell
       (cond
         ((zero? type) ; Buy order
          (let process-buy ((remaining-amount amount))
            (cond
              ((zero? remaining-amount) ; All fulfilled
               #f)
              ((heap-empty? sell-backlog) ; No sell orders to match
               (heap-add! buy-backlog (cons price remaining-amount)))
              (else
               (let* ((top-sell (heap-min sell-backlog))
                      (sell-price (car top-sell))
                      (sell-amount (cdr top-sell)))
                 (if (<= sell-price price) ; Can fulfill with this sell order
                     (begin
                       (heap-remove-min! sell-backlog)
                       (let ((matched-amount (min remaining-amount sell-amount)))
                         (when (> (- sell-amount matched-amount) 0)
                           (heap-add! sell-backlog (cons sell-price (- sell-amount matched-amount))))
                         (process-buy (- remaining-amount matched-amount))))
                     ; Cannot fulfill with current sell orders (all remaining are too expensive)
                     (heap-add! buy-backlog (cons price remaining-amount))))))))

         ((= type 1) ; Sell order
          (let process-sell ((remaining-amount amount))
            (cond
              ((zero? remaining-amount) ; All fulfilled
               #f)
              ((heap-empty? buy-backlog) ; No buy orders to match
               (heap-add! sell-backlog (cons price remaining-amount)))
              (else
               (let* ((top-buy (heap-min buy-backlog)) ; For a max-heap, heap-min returns the max element
                      (buy-price (car top-buy))
                      (buy-amount (cdr top-buy)))
                 (if (>= buy-price price) ; Can fulfill with this buy order
                     (begin
                       (heap-remove-min! buy-backlog) ; Remove the max element from the max-heap
                       (let ((matched-amount (min remaining-amount buy-amount)))
                         (when (> (- buy-amount matched-amount) 0)
                           (heap-add! buy-backlog (cons buy-price (- buy-amount matched-amount))))
                         (process-sell (- remaining-amount matched-amount))))
                     ; Cannot fulfill with current buy orders (all remaining are too cheap)
                     (heap-add! sell-backlog (cons price remaining-amount)))))))))))
   orders)

  ; Calculate total amount in backlogs
  (define total-backlog-amount 0)

  (heap-for-each (lambda (item) (set! total-backlog-amount (modulo (+ total-backlog-amount (cdr item)) MOD))) buy-backlog)
  (heap-for-each (lambda (item) (set! total-backlog-amount (modulo (+ total-backlog-amount (cdr item)) MOD))) sell-backlog)

  total-backlog-amount)