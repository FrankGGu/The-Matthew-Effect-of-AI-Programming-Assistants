(define/contract (plus-one digits)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([digits (reverse digits)] [carry 1] [res '()])
    (if (null? digits)
        (if (zero? carry)
            res
            (cons carry res))
        (let* ([d (car digits)]
               [sum (+ d carry)]
               [new-d (modulo sum 10)]
               [new-carry (quotient sum 10)])
          (loop (cdr digits) new-carry (cons new-d res))))))