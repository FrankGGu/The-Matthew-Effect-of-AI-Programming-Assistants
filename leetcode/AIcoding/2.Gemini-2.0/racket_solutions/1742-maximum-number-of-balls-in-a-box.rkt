(define (digit-sum n)
  (if (= n 0)
      0
      (+ (remainder n 10) (digit-sum (quotient n 10)))))

(define (max-balls-in-box low high)
  (let ((counts (make-hash)))
    (for ((i (in-range low (+ high 1))))
      (let ((sum (digit-sum i)))
        (hash-update! counts sum (lambda (v) (+ v 1)) 0)))
    (foldr (lambda (k v acc) (max v acc)) 0 counts)))