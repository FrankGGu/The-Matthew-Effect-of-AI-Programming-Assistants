(define (minSubArrayLen target nums)
  (define n (length nums))
  (define (helper start end sum min-len)
    (cond
      ((>= end n) min-len)
      ((>= sum target) (helper start (add1 end) (- sum (list-ref nums start)) (min min-len (- end start))))
      (else (helper start (add1 end) (+ sum (list-ref nums end)) min-len))))
  (let ((result (helper 0 0 0 +inf.0)))
    (if (= result +inf.0) 0 result)))

(define (minSubArrayLen target nums)
  (minSubArrayLen target nums))