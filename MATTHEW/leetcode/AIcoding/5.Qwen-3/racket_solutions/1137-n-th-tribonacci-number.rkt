(define (tribonacci a b c n)
  (if (<= n 2)
      (if (= n 0) a (if (= n 1) b c))
      (tribonacci b c (+ a b c) (- n 1))))

(define/contract (tribonacci-number n)
  (-> exact-integer? exact-integer?)
  (tribonacci 0 1 1 n))