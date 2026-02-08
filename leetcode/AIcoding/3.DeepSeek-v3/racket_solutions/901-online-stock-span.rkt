(define-struct stock (price span))

(define (make-stock-spanner)
  (let ([stack '()])
    (lambda (price)
      (let ([span 1])
        (let loop ()
          (if (and (not (null? stack)) (>= price (stock-price (car stack))))
              (begin
                (set! span (+ span (stock-span (car stack))))
                (set! stack (cdr stack))
                (loop))
              (begin
                (set! stack (cons (make-stock price span) stack))
                span))))))