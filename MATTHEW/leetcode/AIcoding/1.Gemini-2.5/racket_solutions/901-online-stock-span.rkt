(define stock-spanner%
  (class object%
    (init-field [stack '()]) ; Stack stores pairs of (price . span)

    (define/public (next price)
      (let ([current-span 1])
        (let loop ([current-s (get-field stack)])
          (cond
            [(and (not (empty? current-s)) (<= (car (car current-s)) price))
             ; If the stack is not empty and the top element's price is less than or equal to the current price
             ; Add its span to current-span and continue popping
             (set! current-span (+ current-span (cdr (car current-s))))
             (loop (cdr current-s))]
            [else
             ; Stack is empty or the top element's price is greater than the current price
             ; Push the new (price . current-span) onto the remaining stack
             (set-field! stack (cons (cons price current-span) current-s))
             current-span])))))