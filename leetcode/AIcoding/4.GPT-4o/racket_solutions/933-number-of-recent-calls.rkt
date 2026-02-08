(define recent-calls
  (lambda ()
    (define timestamps '())
    (define (ping t)
      (set! timestamps (filter (lambda (x) (>= t (- x 3000))) timestamps))
      (set! timestamps (cons t timestamps))
      (length timestamps))
    (lambda (method . args)
      (cond
        ((equal? method 'ping) (apply ping args))))))

(define rc (recent-calls))
((rc 'ping) 1)
((rc 'ping) 100)
((rc 'ping) 3001)
((rc 'ping) 3002)