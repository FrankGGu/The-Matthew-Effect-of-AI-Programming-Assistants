(define (sumOfValues A K)
  (define (count-set-bits n)
    (if (= n 0)
        0
        (+ (modulo n 2) (count-set-bits (quotient n 2)))))
  (define (sum-at-k-set-bits idx acc)
    (if (null? idx)
        acc
        (let ((i (car idx)))
          (if (= (count-set-bits i) K)
              (sum-at-k-set-bits (cdr idx) (+ acc (list-ref A i)))
              (sum-at-k-set-bits (cdr idx) acc)))))
  (sum-at-k-set-bits (iota (length A)) 0))