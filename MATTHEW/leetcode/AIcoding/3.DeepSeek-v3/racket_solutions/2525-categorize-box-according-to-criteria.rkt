(define/contract (categorize-box length width height mass)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? string?)
  (let* ([volume (* length width height)]
         [bulky? (or (>= length 10000)
                     (>= width 10000)
                     (>= height 10000)
                     (>= volume 1000000000))]
         [heavy? (>= mass 100)]
         [category (cond
                     [(and bulky? heavy?) "Both"]
                     [bulky? "Bulky"]
                     [heavy? "Heavy"]
                     [else "Neither"])])
    category))