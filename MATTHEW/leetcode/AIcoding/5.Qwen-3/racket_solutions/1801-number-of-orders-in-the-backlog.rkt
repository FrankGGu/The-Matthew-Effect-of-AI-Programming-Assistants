#lang racket

(define (number-of-orders-in-the-backlog orders)
  (define buy-heap (make-heap #:priority >))
  (define sell-heap (make-heap #:priority <))
  (for-each
   (lambda (order)
     (match order
       [(list 'buy price quantity)
        (let loop ()
          (when (and (not (heap-empty? sell-heap))
                     (<= (heap-top sell-heap) price))
            (let* ([sell-price (heap-top sell-heap)]
                   [sell-quantity (heap-ref sell-heap)])
              (if (<= quantity sell-quantity)
                  (begin
                    (heap-pop sell-heap)
                    (heap-add sell-heap (- sell-quantity quantity))
                    (set! quantity 0))
                  (begin
                    (heap-pop sell-heap)
                    (set! quantity (- quantity sell-quantity))))))
          (when (> quantity 0)
            (heap-add buy-heap (list price quantity))))]
       [(list 'sell price quantity)
        (let loop ()
          (when (and (not (heap-empty? buy-heap))
                     (>= (heap-top buy-heap) price))
            (let* ([buy-price (heap-top buy-heap)]
                   [buy-quantity (heap-ref buy-heap)])
              (if (<= quantity buy-quantity)
                  (begin
                    (heap-pop buy-heap)
                    (heap-add buy-heap (- buy-quantity quantity))
                    (set! quantity 0))
                  (begin
                    (heap-pop buy-heap)
                    (set! quantity (- quantity buy-quantity))))))
          (when (> quantity 0)
            (heap-add sell-heap (list price quantity)))])))
   orders)
  (apply + (map cadr (heap->list buy-heap)) (map cadr (heap->list sell-heap))))