(define/contract (difference-of-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (digit-sum n)
    (if (< n 10)
        n
        (+ (modulo n 10) (digit-sum (quotient n 10)))))
  (abs (- (apply + nums)
          (apply + (map digit-sum nums)))))