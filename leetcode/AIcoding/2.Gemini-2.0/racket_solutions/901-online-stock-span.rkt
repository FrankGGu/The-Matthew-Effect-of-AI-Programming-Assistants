(define stack '())

(define (StockSpanner)
  (set! stack '()))

(define (next price)
  (define span 1)
  (define (helper)
    (cond [(null? stack) #f]
          [(<= (cadr (car stack)) price)
           (set! span (+ span (car (car stack))))
           (set! stack (cdr stack))
           (helper)]
          [else #t]))
  (helper)
  (set! stack (cons (cons span price) stack))
  span)