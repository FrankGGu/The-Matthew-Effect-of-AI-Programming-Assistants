(define (can-split nums k)
  (define (helper cur-sum target count)
    (cond
      (= count k) (if (= cur-sum 0) #t #f)
      (= cur-sum target) (helper 0 target (+ count 1))
      (> cur-sum target) #f
      (else (or (helper (+ cur-sum (car nums)) target count)
                (helper (cdr nums) target count)))))
  (define total-sum (apply + nums))
  (if (not (= (modulo total-sum k) 0)) #f
      (let ((target (/ total-sum k)))
        (helper 0 target 0))))

(define (splitArraySameAverage nums)
  (define k (length nums))
  (can-split nums k))

(splitArraySameAverage '(1 2 3 4 5 6 7 8))