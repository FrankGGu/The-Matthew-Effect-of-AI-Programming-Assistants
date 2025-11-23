(define (max-profit prices)
  (define (helper i buy? hold)
    (cond [(>= i (length prices)) 0]
          [buy? (max (- (helper (+ i 1) #f (- hold (list-ref prices i))) (list-ref prices i))
                     (helper (+ i 1) buy? hold))]
          [else (max (+ (helper (+ i 1) #t (+ hold (list-ref prices i))) (list-ref prices i))
                     (helper (+ i 1) buy? hold))]))
  (helper 0 #t 0))