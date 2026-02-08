#lang racket

(define/contract (count-sub-multisets nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define MOD 1000000007)
  (define freq (make-hash))

  (for ([num nums])
    (hash-update! freq num add1 0))

  (define dp (make-vector (+ target 1) 0))
  (vector-set! dp 0 1)

  (for ([(num cnt) (in-hash freq)])
    (for ([j (in-range target (sub1 num) -1)])
      (for ([k (in-range 1 (add1 cnt))])
        (when (>= j (* k num))
          (vector-set! dp j 
                       (modulo (+ (vector-ref dp j) 
                                  (vector-ref dp (- j (* k num))))
                       MOD))))))

  (vector-ref dp target))