(define (smallestRepunitDivByK K)
  (define (helper remainder length)
    (if (= remainder 0)
        length
        (let ((new-remainder (modulo (+ (* remainder 10) 1) K)))
          (if (memv new-remainder (take 1000 (map (λ (x) (modulo x K)))))
              -1
              (helper new-remainder (+ length 1))))))
  (helper 0 0))