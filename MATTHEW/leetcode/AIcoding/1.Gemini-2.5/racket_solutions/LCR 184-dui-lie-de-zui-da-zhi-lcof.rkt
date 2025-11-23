#lang racket

(struct self-checkout-system (num-cashiers cashier-finish-times) #:mutable)

(define (new-self-checkout-system num-cashiers)
  (self-checkout-system num-cashiers (make-vector num-cashiers 0)))

(define (add-customer! sys arrival-time service-time)
  (let* ([cashier-finish-times (self-checkout-system-cashier-finish-times sys)]
         [num-cashiers (self-checkout-system-num-cashiers sys)])
    (unless (> num-cashiers 0)
      (error "Cannot add customer to system with no cashiers"))

    (let* ([min-finish-time (vector-ref cashier-finish-times 0)]
           [min-idx 0])

      (for ([i (in-range 1 num-cashiers)])
        (let ([current-finish-time (vector-ref cashier-finish-times i)])
          (when (< current-finish-time min-finish-time)
            (set! min-finish-time current-finish-time)
            (set! min-idx i))))

      (let* ([start-checkout-time (max arrival-time min-finish-time)]
             [finish-checkout-time (+ start-checkout-time service-time)])
        (vector-set! cashier-finish-times min-idx finish-checkout-time)
        finish-checkout-time))))