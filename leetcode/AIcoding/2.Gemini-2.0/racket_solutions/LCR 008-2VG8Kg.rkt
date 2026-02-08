(define (min-sub-array-len target nums)
  (define n (length nums))
  (define (helper left right current-sum min-len)
    (cond
      [(>= right n)
       (if (= min-len (add1 n)) 0 min-len)]
      [(< current-sum target)
       (helper left (add1 right) (+ current-sum (list-ref nums right)) min-len)]
      [else
       (helper (add1 left) right (- current-sum (list-ref nums left)) (min min-len (- right left)))]))

  (helper 0 0 0 (add1 n)))