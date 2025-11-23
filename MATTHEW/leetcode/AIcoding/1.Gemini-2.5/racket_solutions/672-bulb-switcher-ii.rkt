(define (bulb-switcher-ii n m)
  (cond
    ((zero? m) 1)
    ((= m 1)
     (cond
       ((= n 1) 2)
       ((= n 2) 4)
       (else 5)))
    (else ; m >= 2
     (cond
       ((= n 1) 2)
       ((= n 2) 4)
       (else 8))))
  )