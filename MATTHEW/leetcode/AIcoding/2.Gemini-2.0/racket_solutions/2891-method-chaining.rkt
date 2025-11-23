(define (create-counter initial-value)
  (let ((count (box initial-value)))
    (define (increment)
      (set-box! count (+ (unbox count) 1))
      (lambda args (apply identity args)))
    (define (decrement)
      (set-box! count (- (unbox count) 1))
      (lambda args (apply identity args)))
    (define (reset)
      (set-box! count initial-value)
      (lambda args (apply identity args)))
    (define (get-value)
      (unbox count))
    (define (result args)
      (cond
        [(null? args) (get-value)]
        [(equal? (car args) 'increment) (increment)]
        [(equal? (car args) 'decrement) (decrement)]
        [(equal? (car args) 'reset) (reset)]
        [else (get-value)]))
    result))