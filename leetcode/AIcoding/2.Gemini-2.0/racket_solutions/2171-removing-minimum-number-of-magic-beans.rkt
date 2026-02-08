(define (minimum-removal magic-beans)
  (let* ([n (length magic-beans)]
         [sorted-beans (sort magic-beans <)]
         [total-sum (apply + sorted-beans)]
         [min-removal total-sum])
    (for/fold ([min-removal min-removal])
              ([i (in-range n)])
      (let* ([current-bean (list-ref sorted-beans i)]
             [removal (- total-sum (* current-bean (- n i)))])
        (min min-removal removal)))))