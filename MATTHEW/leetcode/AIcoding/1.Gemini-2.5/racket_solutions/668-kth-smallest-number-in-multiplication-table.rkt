(define (find-kth-smallest m n k)
  (define (count-less-equal val m n)
    (for/sum ([i (in-range 1 (add1 m))])
      (min n (quotient val i))))

  (let loop ((low 1) (high (* m n)) (ans (* m n)))
    (if (> low high)
        ans
        (let* ((mid (+ low (quotient (- high low) 2)))
               (count (count-less-equal mid m n)))
          (if (>= count k)
              (loop low (sub1 mid) mid)
              (loop (add1 mid) high ans))))))