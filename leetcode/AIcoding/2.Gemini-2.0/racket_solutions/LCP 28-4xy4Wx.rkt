(define (purchasePlans costs money)
  (define sorted-costs (sort costs <))
  (define (count-pairs l r count)
    (cond
      [(>= l r) count]
      [else
       (let ([sum (+ (list-ref sorted-costs l) (list-ref sorted-costs r))])
         (if (<= sum money)
             (count-pairs (add1 l) r (modulo (+ count (- r l)) 1000000007))
             (count-pairs l (sub1 r) count)))
       ]))
  (count-pairs 0 (- (length sorted-costs) 1) 0))