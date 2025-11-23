(define/contract (max-divisor-score divisors nums)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (count-divisible d n)
    (for/sum ([num nums])
      (if (zero? (modulo num d)) 1 0))
  (let loop ([ds divisors]
             [max-score -1]
             [result (first divisors)])
    (if (null? ds)
        result
        (let* ([d (first ds)]
               [score (count-divisible d nums)])
          (cond
            [(> score max-score) (loop (rest ds) score d)]
            [(= score max-score) (loop (rest ds) max-score (min d result))]
            [else (loop (rest ds) max-score result)])))))