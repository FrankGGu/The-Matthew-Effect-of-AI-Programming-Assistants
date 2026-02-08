(define (change-data-type lst)
  (map (lambda (x)
         (cond
           [(string? x) (string->number x)]
           [(number? x) (number->string x)]
           [else x]))
       lst))