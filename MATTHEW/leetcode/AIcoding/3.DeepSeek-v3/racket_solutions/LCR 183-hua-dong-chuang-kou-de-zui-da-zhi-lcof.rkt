(define/contract (max-altitude gain)
  (-> (listof exact-integer?) exact-integer?)
  (define (helper lst current max-alt)
    (if (null? lst)
        max-alt
        (let ([new-alt (+ current (car lst))])
          (helper (cdr lst) new-alt (max max-alt new-alt)))))
  (helper gain 0 0))