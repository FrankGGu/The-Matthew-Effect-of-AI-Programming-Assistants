(define/contract (count-subsequences nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define mod 1000000007)
  (define n (length nums))
  (define max-num (apply max nums))
  (define dp (make-hash))

  (for ([num (in-list nums)])
    (hash-update! dp num (lambda (v) (modulo (+ v 1) mod)) (lambda () 0)))

  (for ([i (in-range 1 (add1 max-num))])
    (for ([j (in-range (* 2 i) (add1 max-num) i])
      (hash-update! dp i (lambda (v) (modulo (+ v (hash-ref dp j 0)) mod)) (lambda () 0))))

  (define result 0)
  (for ([(g cnt) (in-hash dp)])
    (when (>= g k)
      (set! result (modulo (+ result cnt) mod))))

  result)