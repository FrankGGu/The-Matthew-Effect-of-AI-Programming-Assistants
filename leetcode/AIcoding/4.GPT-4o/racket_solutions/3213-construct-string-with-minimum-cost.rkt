(define (minimumCostString s)
  (define (cost c)
    (if (char? c) (char->integer c) 0))

  (define total-cost 0)
  (define (helper lst)
    (if (null? lst)
        total-cost
        (begin
          (set! total-cost (+ total-cost (cost (car lst))))
          (helper (cdr lst)))))

  (helper (string->list s))
  total-cost)

(define (minimumCost s)
  (minimumCostString s))