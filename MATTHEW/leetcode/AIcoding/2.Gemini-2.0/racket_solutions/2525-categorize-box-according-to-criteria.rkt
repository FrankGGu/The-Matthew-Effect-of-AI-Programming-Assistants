(define (categorize-box length width height mass)
  (define volume (* length width height))
  (define bulky? (or (> length 10000) (> width 10000) (> height 10000) (> volume 1000000000)))
  (define heavy? (> mass 100))
  (cond
    [(and bulky? heavy?) "Both"]
    [bulky? "Bulky"]
    [heavy? "Heavy"]
    [else "Neither"]))