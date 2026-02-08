(define (minOperations nums)
  (define n (length nums))
  (define ones (count (λ (x) (= x 1)) nums))
  (if (> ones 0)
      (- n ones)
      (let loop ((i 0) (min-ops #f))
        (cond
          ((= i (- n 1)) (if min-ops min-ops -1))
          (else
           (let loop2 ((j (+ i 1)) (g (list-ref nums i)))
             (cond
               ((= j n) (loop (+ i 1) min-ops))
               (else
                (let ((g (gcd g (list-ref nums j))))
                  (cond
                    ((= g 1) (loop (+ i 1) (if min-ops (min min-ops (- (+ j 1) i 1)) (- (+ j 1) i 1))))
                    (else (loop2 (+ j 1) g))))))))))))