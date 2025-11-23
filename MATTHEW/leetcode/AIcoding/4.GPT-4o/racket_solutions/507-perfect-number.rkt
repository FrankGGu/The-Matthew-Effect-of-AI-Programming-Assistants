(define (checkPerfectNumber num)
  (if (= num 1)
      #f
      (define (sum-of-divisors n)
        (define (helper i total)
          (if (> i (sqrt n))
              total
              (if (= (modulo n i) 0)
                  (helper (+ i 1) (+ total i (+ (if (= i (/ n i)) 0 (/ n i) 0))))
                  (helper (+ i 1) total)))
        (helper 2 0))
      (= (sum-of-divisors num) num)))

(checkPerfectNumber)