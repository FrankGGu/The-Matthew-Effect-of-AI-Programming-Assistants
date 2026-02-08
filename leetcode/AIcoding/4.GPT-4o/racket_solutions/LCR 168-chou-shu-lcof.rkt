(define (isUgly n)
  (if (<= n 0) #f
      (or (= n 1)
          (and (isUgly (if (= (mod n 2) 0) (/ n 2) n))
               (isUgly (if (= (mod n 3) 0) (/ n 3) n))
               (isUgly (if (= (mod n 5) 0) (/ n 5) n))))))

(define (nthUglyNumber n)
  (define (helper count num)
    (cond ((= count n) num)
          ((isUgly num) (helper (+ count 1) (+ num 1)))
          (else (helper count (+ num 1)))))
  (helper 0 1))