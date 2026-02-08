(define/contract (sum-of-squares nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (for/sum ([i (in-range 1 (add1 n))]
            #:when (zero? (modulo n i)))
    (let ([num (list-ref nums (sub1 i))])
      (* num num))))