(define (shopping-offers price special needs)
  (define num-items (length price))
  (define memo (make-hash))

  (define (calculate-individual-cost current-needs)
    (for/sum ([p price]
              [n current-needs])
      (* p n)))

  (define (solve current-needs)
    (cond
      [(hash-has-key? memo current-needs)
       (hash-ref memo current-needs)]
      [else
       (define min-cost (calculate-individual-cost current-needs))

       (for ([offer special])
         (define offer-price (last offer))
         (define offer-quantities (drop-right offer 1))

         (define (can-apply-offer? current-needs offer-quantities)
           (for/and ([oq offer-quantities]
                     [cn current-needs])
             (<= oq cn)))

         (when (can-apply-offer? current-needs offer-quantities)
           (define next-needs
             (for/list ([oq offer-quantities]
                        [cn current-needs])
               (- cn oq)))

           (set! min-cost (min min-cost (+ offer-price (solve next-needs))))))

       (hash-set! memo current-needs min-cost)
       min-cost]))

  (solve needs))