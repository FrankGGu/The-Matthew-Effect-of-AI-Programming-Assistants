(define/contract (min-number-operations target)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([prev 0] [res 0] [lst target])
    (if (null? lst)
        res
        (let ([curr (car lst)])
          (loop curr (+ res (max 0 (- curr prev))) (cdr lst)))))