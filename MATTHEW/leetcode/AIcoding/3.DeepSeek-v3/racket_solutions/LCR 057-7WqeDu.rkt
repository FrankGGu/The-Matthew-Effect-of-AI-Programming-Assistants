(define/contract (contains-nearby-almost-duplicate nums k t)
  (-> (listof exact-integer?) exact-integer? exact-integer? boolean?)
  (let loop ([i 0] [seen (make-hash)])
    (cond
      [(>= i (length nums)) #f]
      [else
       (let ([num (list-ref nums i)])
       (for/or ([j (in-range (max 0 (- i k)) i)])
         (<= (abs (- num (list-ref nums j))) t))
       (loop (add1 i) seen)])))