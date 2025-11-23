(define/contract (contains-nearby-duplicate nums k)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let loop ([i 0] [seen (hash)])
    (cond
      [(>= i (length nums)) #f]
      [(hash-has-key? seen (list-ref nums i))
       (if (<= (abs (- i (hash-ref seen (list-ref nums i)))) k)
           #t
           (loop (add1 i) (hash-set seen (list-ref nums i) i)))]
      [else (loop (add1 i) (hash-set seen (list-ref nums i) i))])))