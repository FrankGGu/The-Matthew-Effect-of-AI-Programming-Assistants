(define (time-needed-to-buy-tickets tickets k)
  (let ([target-tickets (list-ref tickets k)])
    (define (calculate-time current-idx remaining-tickets total-acc-time)
      (cond
        [(empty? remaining-tickets) total-acc-time]
        [else
         (let ([num-tickets-at-current-pos (car remaining-tickets)])
           (calculate-time
            (+ current-idx 1)
            (cdr remaining-tickets)
            (+ total-acc-time
               (if (<= current-idx k)
                   (min num-tickets-at-current-pos target-tickets)
                   (min num-tickets-at-current-pos (- target-tickets 1))))))]))
    (calculate-time 0 tickets 0)))