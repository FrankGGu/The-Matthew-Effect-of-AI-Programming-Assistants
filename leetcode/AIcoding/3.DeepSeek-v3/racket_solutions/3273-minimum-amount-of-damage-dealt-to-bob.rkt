(define/contract (minimum-damage alice-arrows bob-arrows)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [damage 0] [a alice-arrows] [b bob-arrows])
    (if (= i 12)
        damage
        (let ([a-arrow (list-ref a i)]
              [b-arrow (list-ref b i)])
            (if (> a-arrow b-arrow)
                (loop (add1 i) (+ damage i) a b)
                (loop (add1 i) damage a b))))))