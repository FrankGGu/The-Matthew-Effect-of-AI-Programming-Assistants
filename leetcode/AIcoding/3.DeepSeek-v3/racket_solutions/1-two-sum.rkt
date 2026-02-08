(define/contract (two-sum nums target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let loop ([i 0] [seen (hash)])
    (cond
      [(>= i (length nums)) (list)]
      [(hash-has-key? seen (- target (list-ref nums i)))
       (list (hash-ref seen (- target (list-ref nums i))) i)]
      [else (loop (add1 i) (hash-set seen (list-ref nums i) i))])))