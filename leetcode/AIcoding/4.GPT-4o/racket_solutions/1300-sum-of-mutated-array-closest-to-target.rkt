(define (find-best-value arr target)
  (define (check mid)
    (apply + (map (λ (x) (min x mid)) arr)))

  (define (binary-search low high)
    (if (= low high)
        low
        (let* ((mid (quotient (+ low high) 2))
               (sum (check mid)))
          (cond ((< sum target) (binary-search (+ mid 1) high))
                ((> sum target) (binary-search low mid))
                (else mid)))))

  (define low 0)
  (define high (apply max arr))

  (define best (binary-search low high))
  (let ((sum (check best))
        (next-sum (check (+ best 1))))
    (if (<= (abs (- sum target)) (abs (- next-sum target)))
        best
        (+ best 1))))

(find-best-value '(1 2 3 4 5) 10)
(find-best-value '(2 3 5) 10)
(find-best-value '(60864 25114 22526 26516 51247) 46803)