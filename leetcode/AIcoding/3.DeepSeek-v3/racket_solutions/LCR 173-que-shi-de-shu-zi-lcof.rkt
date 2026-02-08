(define/contract (missing-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)])
    (- (/ (* n (+ n 1)) 2) (apply + nums)))