(define/contract (file-combination target)
  (-> exact-integer? (listof (listof exact-integer?)))
  (define res '())
  (define (helper l r sum)
    (cond
      [(> l (quotient target 2)) res]
      [(= sum target) (begin (set! res (cons (range l (+ r 1)) res)) (helper (+ l 1) (+ l 2) (+ l 1 l 2)))]
      [(< sum target) (helper l (+ r 1) (+ sum (+ r 1)))]
      [else (helper (+ l 1) r (- sum l))]))
  (helper 1 2 3)
  (reverse res))