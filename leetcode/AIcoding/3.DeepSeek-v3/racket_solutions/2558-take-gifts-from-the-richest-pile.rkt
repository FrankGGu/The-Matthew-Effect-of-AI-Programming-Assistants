(define/contract (pick-gifts gifts k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([gifts (sort gifts >)] [k k])
    (if (or (zero? k) (null? gifts))
        (apply + gifts)
        (let* ([max-gift (first gifts)]
               [remaining-gifts (rest gifts)]
               [new-gift (exact-floor (sqrt max-gift))]
          (loop (sort (cons new-gift remaining-gifts) >) (sub1 k))))))